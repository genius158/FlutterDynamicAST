import 'dart:async';
import 'dart:convert';

import 'package:ast_test/default_register.dart';

/// [dvm] dynamic vm 执行器
/// Create by yanxianwei
/// Date: 2022-03-08
///
class DVM {
  /// className ： class
  final classMap = {};

  /// funcName ： function
  final topFuncMap = {};

  /// 拿去方法映射，目标target
  final Register? register;

  DVM(this.register, String astStr) {
    _build(astStr);
  }

  Map? _methodBody(String? clazz, String method, Map? args) {
    if (clazz != null) {
      Map? methods = classMap[clazz];
      if (methods == null) return null;
      final clazzMethod = methods[_methodTag(method, args?.length ?? 0)];
      if (clazzMethod == null) return null;
      return clazzMethod["body"];
    }
    return null;
  }

  dynamic execute(String? clazz, String method, Map? args) {
    final Map? methodBody = _methodBody(clazz, method, args);
    if (methodBody == null) return;
    var result = _expressions(methodBody, args ?? {});
    if (result is _ReturnStatement) {
      if (result is! _AwaitExpression) return result.result;
      return result.result.resFuture;
    }
    if (result is! _AwaitExpression) return result;
    return result.resFuture;
  }

  dynamic _expressions(dynamic condition, Map args) {
    if (condition == null) return null;
    if (condition is _ReturnStatement) return condition;
    switch (condition["type"]) {
      case "SimpleStringLiteral":
        return condition["value"];
      case "NumericLiteral":
        condition["lexeme"];
        return condition["value"];
      case "DoubleLiteral":
        return condition["value"];
      case "MapLiteralEntry":
        return {
          _expressions(condition["key"], args):
              _expressions(condition["value"], args)
        };
      case "SetOrMapLiteral":
        List elements = condition["elements"];
        // todo set ？？？
        final map = {};
        for (var entity in elements) {
          map.addAll(_expressions(entity, args));
        }
        return map;
      case "ListLiteral":
        List elements = condition["elements"];
        final argumentList = [];
        for (Map arg in elements) {
          argumentList.add(_expressions(arg, args));
        }
        return argumentList;
      /* ------------------ divide --------------- */
      case "SimpleIdentifier":
        return condition;

      case "PostfixExpression":
        var operand = _expressions(condition["operand"], args);
        if (_isParamsId(operand)) {
          return _executeLexeme(operand["name"], 0, condition["lexeme"], args);
        }
        return _executeLexeme(operand, 0, condition["lexeme"], args);

      case "IndexExpression":
        return [
          _expressions(condition["target"], args),
          _expressions(condition["index"], args)
        ];

      case "IfStatement":
        if (_expressions(condition["condition"], args)) {
          return _expressions(condition["thenStatement"], args);
        } else {
          return _expressions(condition["elseStatement"], args);
        }
      case "ArgumentList":
        final argumentList = [];
        final arguments = condition["arguments"];
        for (Map arg in arguments) {
          dynamic data = _expressions(arg, args);
          argumentList.add(_warpValueIfId(data, args));
        }
        return argumentList;
      case "MethodInvocation":
        final methodName = _expressions(condition["methodName"], args)["name"];
        var target =
            _warpValueIfId(_expressions(condition["target"], args), args);
        final argumentList = _expressions(condition["argumentList"], args);

        dynamic func;
        // 现在类里找注册的方法
        if (register != null) {
          target = register!.target;
          func = register!.funcMap[_methodTag(methodName, argumentList.length)];
        } else {
          // 再全局找
          var funcMap = Map.of(DefaultRegister.instance.funcMap);
          func = funcMap[_methodTag(methodName, argumentList.length)];
        }

        return target != null ? func(target, argumentList) : func(argumentList);

      case "ExpressionStatement":
        return _expressions(condition["expression"], args);
      case "ConditionalExpression":
        if (_expressions(condition["condition"], args)) {
          return _expressions(condition["thenExpression"], args);
        } else {
          return _expressions(condition["elseExpression"], args);
        }

      case "PrefixExpression":
        var res = _expressions(condition["operand"], args);
        if (_isParamsId(res)) {
          args[res["name"]] =
              _calculate(null, _warpValueIfId(res, args), condition["lexeme"]);
          return _warpValueIfId(res, args);
        }
        return _calculate(null, res, condition["lexeme"]);

      case "AssignmentExpression":
        final left = _expressions(condition["leftHandSide"], args);
        final right = _warpValueIfId(
            _expressions(condition["rightHandSide"], args), args);
        final lexeme = condition["lexeme"];
        var map = args;
        if (left is List && left.length == 2) {
          return _executeLexeme(left[1], right, lexeme, map[left[0]["name"]]);
        }
        return _executeLexeme(left["name"], right, lexeme, args);

      case "InterpolationString":
        return condition["value"];
      case "InterpolationExpression":
        return _expressions(condition["expression"], args);
      case "StringInterpolation":
        List elements = condition["elements"];
        var res = "";
        for (int i = 0; i < elements.length; i++) {
          final element = elements[i];
          if (element == null) continue;
          final result = _warpValueIfId(_expressions(element, args), args);
          if (result is _AwaitExpression) {
            return result
              ..then((value) async {
                res = "$res$value";
                while (++i < elements.length) {
                  final ele = elements[i];
                  if (ele == null) continue;
                  final next = _warpValueIfId(_expressions(ele, args), args);
                  res = "$res${await _awaitVal(next)}";
                }
                return res;
              });
          } else {
            res = "$res$result";
          }
        }
        return res;

      case "AwaitExpression":
        return _AwaitExpression(_expressions(condition["expression"], args),
            type: condition["expression"].toString());

      case "ReturnStatement":
        return _ReturnStatement(
            _warpValueIfId(_expressions(condition["expression"], args), args));

      case "BinaryExpression":
        final lexeme = condition["lexeme"];
        final leftValue =
            _warpValueIfId(_expressions(condition["leftOperand"], args), args);
        final rightValue =
            _warpValueIfId(_expressions(condition["rightOperand"], args), args);
        if (leftValue is _AwaitExpression || rightValue is _AwaitExpression) {
          return _AwaitExpression(
              Future(() async => _calculate(await _awaitVal(leftValue),
                  await _awaitVal(rightValue), lexeme)),
              type: condition.toString());
        }

        return _calculate(leftValue, rightValue, lexeme);

      // 赋值 表达式
      case "VariableDeclarationStatement":
        return _expressions(condition["variables"], args);
      case "VariableDeclarationList":
        final variables = condition["variables"];
        for (int i = 0; i < variables.length; i++) {
          final variable = variables[i];
          if (variable == null) return null;
          final result = _expressions(variable, args);
          if (result is _AwaitExpression) {
            return result
              ..then((unused) async {
                while (++i < variables.length) {
                  final ele = variables[i];
                  final result = _expressions(ele, args);
                  await _awaitVal(result);
                }
              });
          }
        }
        return null;
      case "VariableDeclarator":
        final tag = _expressions(condition["name"], args)["name"];
        final initializer = _expressions(condition["initializer"], args);
        if (initializer is _AwaitExpression) {
          return initializer
            ..then((value) => {args[tag] = _warpValueIfId(value, args)});
        } else {
          args[tag] = _warpValueIfId(initializer, args);
        }
        return null;

      case "BlockFunctionBody":
        return _expressions(condition["block"], args);
      case "Block":
        final statements = condition["statements"];
        for (int i = 0; i < statements.length; i++) {
          final statement = statements[i];
          if (statement == null) return null;
          final result = _expressions(statement, args);
          if (result is _ReturnStatement) return result;
          if (result is _AwaitExpression) {
            return result
              ..then((value) async {
                while (++i < statements.length) {
                  final ele = statements[i];
                  final next = _warpValueIfId(_expressions(ele, args), args);
                  final awaitVal = await _awaitVal(next);
                  if (awaitVal is _ReturnStatement) {
                    return _awaitVal(awaitVal.result);
                  }
                }
              });
          }
        }
    }
    return null;
  }

  _build(String ast) {
    Map? map;
    try {
      map = json.decode(ast);
    } catch (e) {
      print(e);
      return;
    }

    final mapAst = map!;
    dynamic classOrFunc = _find(mapAst, ["declarations"]);
    if (classOrFunc == null) return;

    for (Map? map in classOrFunc) {
      if (map == null) continue;
      if (map["type"] == "ClassDeclaration") {
        final className = map["name"]["name"];
        if (classMap[className] == null) {
          classMap[className] = {};
        }
        _findMethodNode(classMap[className], map["members"]);
      } else if (map["type"] == "FunctionDeclaration") {
        _findTopFuncNode(map);
      }
    }
  }

  dynamic _find(Map? map, List<String> tags) {
    if (map == null) return null;
    var list = [];
    for (var entity in map.entries) {
      if (tags.contains(entity.key)) list.addAll(entity.value);
    }
    return list;
  }

  void _findMethodNode(Map clazz, List? members) {
    if (members == null) return;
    for (int i = 0; i < members.length; i++) {
      final Map? ast = members[i];
      if (ast == null) continue;
      if (ast["type"] == "MethodDeclaration") {
        final methodName = ast["name"]["name"];
        final parametersCount = (ast["parameters"]["args"])?.length ?? 0;
        clazz[_methodTag(methodName, parametersCount)] = ast;
      }
    }
  }

  void _findTopFuncNode(Map map) {
    final methodName = map["name"]["name"];
    final parametersCount =
        (map["functionExpression"]["parameters"]["args"])?.length ?? 0;

    topFuncMap[_methodTag(methodName, parametersCount)] = map;
  }

  String _methodTag(methodName, argsCount) {
    return "$methodName@$argsCount";
  }

  dynamic _getParamsId(Map condition, Map args) => args[condition["name"]];

  bool _isParamsId(condition) {
    if (condition is! Map) return false;
    return condition["type"] == "SimpleIdentifier";
  }

  /// 把临时变量转换成数值
  dynamic _warpValueIfId(value, Map args) {
    if (value == null) return null;
    if (_isParamsId(value)) {
      return _getParamsId(value, args);
    }
    return value;
  }

  dynamic _calculate(a, b, lexeme) {
    if (a == null) {
      switch (lexeme) {
        case "++":
          return ++b;
        case "--":
          return --b;
      }
    }
    switch (lexeme) {
      case "+":
        return (a ?? 0) + b;
      case "-":
        return (a ?? 0) - b;
      case "*":
        return (a ?? 0) * b;
      case "/":
        return (a ?? 0) / b;
      case "<<":
        return (a ?? 0) << b;
      case ">>":
        return (a ?? 0) >> b;
      case "|":
        return (a ?? 0) | b;
      case "&":
        return (a ?? 0) & b;
      case "^":
        return (a ?? 0) ^ b;
      case "%":
        return (a ?? 0) % b;
      case "==":
        return (a ?? 0) == b;
      case "??":
        return a ?? b;
    }
  }

  dynamic _executeLexeme(left, right, lexeme, dynamic args) {
    switch (lexeme) {
      case "??=":
        args[left] ??= right;
        return args[left];
      case "=":
        args[left] = right;
        break;
      case "+=":
        args[left] = args[left] + right;
        return args[left];
      case "-=":
        args[left] = args[left] - right;
        return args[left];
      case "++":
        args[left] = args[left] + 1;
        return args[left];
      case "--":
        args[left] = args[left] - 1;
        return args[left];
    }
  }

  bool hotFix(String clazz, String method, int argsCount) {
    Map? methods = classMap[clazz];
    if (methods == null) return false;
    final clazzMethod = methods[_methodTag(method, argsCount)];
    if (clazzMethod == null) return false;
    return true;
  }
}

class _ReturnStatement {
  dynamic result;

  _ReturnStatement(this.result);
}

_awaitVal(v) {
  if (v is _AwaitExpression) return v.future;
  return Future.value(v);
}

class _AwaitExpression {
  late Future future;
  final type;

  _AwaitExpression(result, {this.type}) {
    future = Future.value(result);
  }

  void then<R>(onValue) => future = future.then(onValue);

  get resFuture {
    Completer completer = Completer();
    then((res) => completer.complete(res));
    return completer.future;
  }
}

abstract class Register {
  dynamic target;

  Register(this.target);

  Map<String, Function> get funcMap;
}
