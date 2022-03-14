import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:args/args.dart';
import 'package:pub_semver/pub_semver.dart';

/// [simple_ast] 描述
/// Create by yanxianwei
/// Date: 2022-03-08
///

void main(List<String> arguments) {
  exitCode = 0; // presume success
  final parser = ArgParser()..addFlag("file", negatable: false, abbr: 'f');

  var argResults = parser.parse(arguments);
  var paths = List.from(argResults.rest);
  if (paths.isEmpty) {
    paths.add(
        '/Users/didi/AndroidStudioProjects/FlutterDynamicAST/lib/test8.dart');
  }
  generate(paths[0]);
}

final FeatureSet language_2_14_4 = FeatureSet.fromEnableFlags2(
  sdkLanguageVersion: Version.parse('2.14.4'),
  flags: [],
);

//生成AST
Future generate(String path) async {
  if (path.isEmpty) {
    stdout.writeln("No file found");
  } else {
    await _handleError(path);
    if (exitCode == 2) {
      try {
        var parseResult = parseFile(path: path, featureSet: language_2_14_4);
        var compilationUnit = parseResult.unit;
        //遍历AST
        var astData = compilationUnit.accept(MyAstVisitor());
        stdout.writeln(jsonEncode(astData));
      } catch (e) {
        stdout.writeln('Parse file error: ${e.toString()}');
      }
    }
  }
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}

class MyAstVisitor extends SimpleAstVisitor<Map> {
  /// 遍历节点
  Map? _safelyVisitNode(AstNode? node) {
    if (node != null) {
      return node.accept(this);
    }
    return null;
  }

  /// 遍历节点列表
  List<Map> _safelyVisitNodeList(NodeList<AstNode>? nodes) {
    List<Map> maps = [];
    if (nodes != null) {
      int size = nodes.length;
      for (int i = 0; i < size; i++) {
        dynamic node = nodes[i];
        if (node != null) {
          var res = node.accept(this);
          if (res != null) maps.add(res);
        }
      }
    }
    return maps;
  }

  @override
  Map? visitCompilationUnit(CompilationUnit node) {
    return {
      "type": "CompilationUnit",
      "declarations": _safelyVisitNodeList(node.declarations),
      "directives": _safelyVisitNodeList(node.directives),
    };
  }

  @override
  Map? visitImportDirective(ImportDirective node) {
    return {
      "type": "ImportDirective",
      "keyword": node.keyword.type.name,
      "uri": _safelyVisitNode(node.uri),
    };
  }

  @override
  Map? visitSimpleStringLiteral(SimpleStringLiteral node) {
    return {
      "type": "SimpleStringLiteral",
      "value": node.value,
    };
  }

  @override
  Map? visitClassDeclaration(ClassDeclaration node) {
    return {
      "type": "ClassDeclaration",
      "name": _safelyVisitNode(node.name),
      "isAbstract": node.isAbstract,
      "members": _safelyVisitNodeList(node.members),
    }.appendSource(node);
  }

  @override
  Map? visitBlock(Block node) {
    return {
      "type": "Block",
      "statements": _safelyVisitNodeList(node.statements)
    }.appendSource(node);
  }

  @override
  Map? visitBlockFunctionBody(BlockFunctionBody node) {
    return {
      "type": "BlockFunctionBody",
      "keyword": node.keyword?.type.name,
      "block": _safelyVisitNode(node.block),
    }.appendSource(node);
  }

  @override
  Map? visitExpressionStatement(ExpressionStatement node) {
    return {
      "type": "ExpressionStatement",
      "expression": _safelyVisitNode(node.expression),
    }.appendSource(node);
  }

  @override
  Map? visitMethodInvocation(MethodInvocation node) {
    return {
      "type": "MethodInvocation",
      "methodName": _safelyVisitNode(node.methodName),
      "target": _safelyVisitNode(node.target),
      "argumentList": _safelyVisitNode(node.argumentList),
    }.appendSource(node);
  }

  @override
  Map? visitArgumentList(ArgumentList node) {
    return {
      "type": "ArgumentList",
      "arguments": _safelyVisitNodeList(node.arguments),
    }.appendSource(node);
  }

  @override
  Map? visitVariableDeclaration(VariableDeclaration node) {
    return {
      "type": "VariableDeclarator",
      "name": _safelyVisitNode(node.name),
      "initializer": _safelyVisitNode(node.initializer),
    }.appendSource(node);
  }

  @override
  Map? visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    return {
      "type": "VariableDeclarationStatement",
      "variables": _safelyVisitNode(node.variables),
    }.appendSource(node);
  }

  @override
  Map? visitVariableDeclarationList(VariableDeclarationList node) {
    return {
      "type": "VariableDeclarationList",
      "typeAnnotation": _safelyVisitNode(node.type),
      "variables": _safelyVisitNodeList(node.variables),
    }.appendSource(node);
  }

  @override
  Map? visitSimpleIdentifier(SimpleIdentifier node) {
    return {
      "type": "SimpleIdentifier",
      "isPrivateName": Identifier.isPrivateName(node.name),
      "name": node.name
    }.appendSource(node);
  }

  @override
  Map? visitBinaryExpression(BinaryExpression node) {
    return {
      "type": "BinaryExpression",
      "lexeme": node.operator.lexeme,
      "leftOperand": _safelyVisitNode(node.leftOperand),
      "rightOperand": _safelyVisitNode(node.rightOperand)
    }.appendSource(node);
  }

  @override
  Map? visitIndexExpression(IndexExpression node) {
    return {
      "type": "IndexExpression",
      "index": _safelyVisitNode(node.index),
      "target": _safelyVisitNode(node.target),
    }.appendSource(node);
  }

  @override
  Map? visitIntegerLiteral(IntegerLiteral node) {
    return {"type": "NumericLiteral", "value": node.value}.appendSource(node);
  }

  @override
  Map? visitFunctionDeclaration(FunctionDeclaration node) {
    return {
      "type": "FunctionDeclaration",
      "name": _safelyVisitNode(node.name),
      "returnType": _safelyVisitNode(node.returnType),
      "functionExpression": _safelyVisitNode(node.functionExpression),
    }.appendSource(node);
  }

  @override
  Map? visitFunctionDeclarationStatement(FunctionDeclarationStatement node) {
    return {
      "type": "FunctionDeclarationStatement",
      "functionDeclaration": _safelyVisitNode(node.functionDeclaration),
    }.appendSource(node);
  }

  @override
  Map? visitFunctionExpression(FunctionExpression node) {
    return {
      "type": "FunctionExpression",
      "parameters": _safelyVisitNode(node.parameters),
      "typeParameters": _safelyVisitNode(node.typeParameters),
      "body": _safelyVisitNode(node.body),
    }.appendSource(node);
  }

  @override
  Map? visitExpressionFunctionBody(ExpressionFunctionBody node) {
    return {
      "type": "ExpressionFunctionBody",
      "expression": _safelyVisitNode(node.expression),
    }.appendSource(node);
  }

  @override
  Map? visitMethodDeclaration(MethodDeclaration node) {
    return {
      "type": "MethodDeclaration",
      "name": _safelyVisitNode(node.name),
      "parameters": _safelyVisitNode(node.parameters),
      "typeParameters": _safelyVisitNode(node.typeParameters),
      "body": _safelyVisitNode(node.body),
      "returnType": _safelyVisitNode(node.returnType),
    }.appendSource(node);
  }

  @override
  Map? visitSimpleFormalParameter(SimpleFormalParameter node) {
    return {
      "type": "SimpleFormalParameter",
      "paramType": _safelyVisitNode(node.type),
      "name": node.identifier?.name,
      "identifier": _safelyVisitNode(node.identifier)
    }.appendSource(node);
  }

  @override
  Map? visitFormalParameterList(FormalParameterList node) {
    return {
      "type": "FormalParameterList",
      "args": _safelyVisitNodeList(node.parameters)
    }.appendSource(node);
  }

  @override
  Map? visitDeclaredIdentifier(DeclaredIdentifier node) {
    return {
      "type": "DeclaredIdentifier",
      "identifier": _safelyVisitNode(node.identifier)
    }.appendSource(node);
  }

  @override
  Map? visitNamedType(NamedType node) {
    return {
      "type": "TypeName",
      "name": _safelyVisitNode(node.name),
    }.appendSource(node);
  }

  @override
  Map? visitReturnStatement(ReturnStatement node) {
    return {
      "type": "ReturnStatement",
      "expression": _safelyVisitNode(node.expression),
    }.appendSource(node);
  }

  @override
  Map? visitPrefixedIdentifier(PrefixedIdentifier node) {
    return {
      "type": "PrefixedIdentifier",
      "prefix": _safelyVisitNode(node.prefix),
      "isDeferred": node.isDeferred,
      "identifier": _safelyVisitNode(node.identifier),
    }.appendSource(node);
  }

  @override
  Map? visitIfStatement(IfStatement node) {
    return {
      "type": "IfStatement",
      "condition": _safelyVisitNode(node.condition),
      "thenStatement": _safelyVisitNode(node.thenStatement),
      "elseStatement": _safelyVisitNode(node.elseStatement),
    }.appendSource(node);
  }

  @override
  Map? visitSwitchStatement(SwitchStatement node) {
    return {
      "type": "SwitchStatement",
      "expression": _safelyVisitNode(node.expression),
      "members": _safelyVisitNodeList(node.members),
    }.appendSource(node);
  }

  @override
  Map? visitConditionalExpression(ConditionalExpression node) {
    return {
      "type": "ConditionalExpression",
      "condition": _safelyVisitNode(node.condition),
      "thenExpression": _safelyVisitNode(node.thenExpression),
      "elseExpression": _safelyVisitNode(node.elseExpression),
    }.appendSource(node);
  }

  @override
  Map? visitSwitchCase(SwitchCase node) {
    return {
      "type": "SwitchCase",
      "expression": _safelyVisitNode(node.expression),
      "statements": _safelyVisitNodeList(node.statements),
    }.appendSource(node);
  }

  @override
  Map? visitAssignmentExpression(AssignmentExpression node) {
    return {
      "type": "AssignmentExpression",
      "lexeme": node.operator.type.lexeme,
      "leftHandSide": _safelyVisitNode(node.leftHandSide),
      "rightHandSide": _safelyVisitNode(node.rightHandSide),
    }.appendSource(node);
  }

  @override
  Map? visitBreakStatement(BreakStatement node) {
    return {
      "type": "BreakStatement",
      "target": _safelyVisitNode(node.target),
    }.appendSource(node);
  }

  @override
  Map? visitAwaitExpression(AwaitExpression node) {
    return {
      "type": "AwaitExpression",
      "expression": _safelyVisitNode(node.expression),
    }.appendSource(node);
  }

  @override
  Map? visitPrefixExpression(PrefixExpression node) {
    return {
      "type": "PrefixExpression",
      "lexeme": node.operator.lexeme,
      "operand": _safelyVisitNode(node.operand),
    }.appendSource(node);
  }

  @override
  Map? visitSwitchDefault(SwitchDefault node) {
    return {
      "type": "SwitchDefault",
    }.appendSource(node);
  }

  @override
  Map? visitForStatement(ForStatement node) {
    return {
      "type": "ForStatement",
      "body": _safelyVisitNode(node.body),
      "forLoopParts": _safelyVisitNode(node.forLoopParts),
    }.appendSource(node);
  }

  @override
  Map? visitForEachPartsWithDeclaration(ForEachPartsWithDeclaration node) {
    return {
      "type": "ForEachPartsWithDeclaration",
      "loopVariable": _safelyVisitNode(node.loopVariable),
    }.appendSource(node);
  }

  @override
  Map? visitForEachPartsWithIdentifier(ForEachPartsWithIdentifier node) {
    return {
      "type": "ForEachPartsWithIdentifier",
      "identifier": _safelyVisitNode(node.identifier),
    }.appendSource(node);
  }

  @override
  Map? visitForElement(ForElement node) {
    return {
      "type": "ForElement",
      "forLoopParts": _safelyVisitNode(node.forLoopParts),
      "body": _safelyVisitNode(node.body),
    }.appendSource(node);
  }

  @override
  Map? visitNamedExpression(NamedExpression node) {
    return {
      "type": "NamedExpression",
      "expression": _safelyVisitNode(node.expression),
      "name": _safelyVisitNode(node.name),
    }.appendSource(node);
  }

  @override
  Map? visitListLiteral(ListLiteral node) {
    return {
      "type": "ListLiteral",
      "elements": _safelyVisitNodeList(node.elements),
    }.appendSource(node);
  }

  @override
  Map? visitMapLiteralEntry(MapLiteralEntry node) {
    return {
      "type": "MapLiteralEntry",
      "value": _safelyVisitNode(node.value),
      "key": _safelyVisitNode(node.key),
    }.appendSource(node);
  }

  @override
  Map? visitSetOrMapLiteral(SetOrMapLiteral node) {
    return {
      "type": "SetOrMapLiteral",
      "isMap": node.isMap,
      "isSet": node.isSet,
      "elements": _safelyVisitNodeList(node.elements),
    }.appendSource(node);
  }

  @override
  Map? visitBooleanLiteral(BooleanLiteral node) {
    return {
      "type": "BooleanLiteral",
      "value": node.value,
    }.appendSource(node);
  }

  @override
  Map? visitParenthesizedExpression(ParenthesizedExpression node) {
    return {
      "type": "ParenthesizedExpression",
      "expression": _safelyVisitNode(node.expression),
    }.appendSource(node);
  }

  @override
  Map? visitDoubleLiteral(DoubleLiteral node) {
    return {
      "type": "DoubleLiteral",
      "value": node.value,
    }.appendSource(node);
  }

  @override
  Map? visitStringInterpolation(StringInterpolation node) {
    return {
      "type": "StringInterpolation",
      "elements": _safelyVisitNodeList(node.elements),
    }.appendSource(node);
  }

  @override
  Map? visitInterpolationString(InterpolationString node) {
    return {
      "type": "InterpolationString",
      "value": node.value,
    }.appendSource(node);
  }

  @override
  Map? visitInterpolationExpression(InterpolationExpression node) {
    return {
      "type": "InterpolationExpression",
      "expression": _safelyVisitNode(node.expression),
    }.appendSource(node);
  }

  @override
  Map? visitPostfixExpression(PostfixExpression node) {
    return {
      "type": "PostfixExpression",
      "operand": _safelyVisitNode(node.operand),
      "lexeme": node.operator.lexeme,
    }.appendSource(node);
  }
}

const bool _withSource = false;

extension MapExt on Map {
  Map appendSource(AstNode node) {
    if (_withSource) {
      this["source"] = node.toSource();
    }
    return this;
  }
}
