import 'dart:io';

import 'package:ast_test/dvm.dart';

/// [test.dart] 测试
/// Create by yanxianwei
/// Date: 2022-03-08
///
class Test11 {
  void testFor() {
    for (int i = 0; i < 3; i++) {
      print("testFor $i");
    }
  }

  Future test(String test) async {
    sleep(const Duration(milliseconds: 200));
    return Future(() => test + "sleep 1 seconds ");
  }

  void testWhile()async {
    int i = 0;
    while (true) {

      print("testWhile $i  ${await test("0000000")}");
      // TODO  i++ 等价与 ++i
      if (++i > 5) break;
    }
  }
}

/// 方法注册实现，dvm 需要通过Register 获取对应的方法实现，和目标对象
class _DvmFIXRegister extends Register {
  _DvmFIXRegister(dynamic target) : super(target);
  @override
  final Map<String, Function> funcMap = {
    "test@1": (map, args) => map.test(args[0]),
  };
}

main() {
  Test11 test11 = Test11();
  DVM dvm = new DVM(_DvmFIXRegister(test11), """
{"type":"CompilationUnit","declarations":[{"type":"ClassDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Test11"},"isAbstract":false,"members":[{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"testFor"},"parameters":{"type":"FormalParameterList","args":[]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":null,"block":{"type":"Block","statements":[{"type":"ForStatement","body":{"type":"Block","statements":[{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"print"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"testFor "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"i"}},{"type":"InterpolationString","value":""}]}]}}}]},"forKeyword":"for","forLoopParts":{"type":"ForPartsWithDeclarations","condition":{"type":"BinaryExpression","lexeme":"<","leftOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"i"},"rightOperand":{"type":"NumericLiteral","value":3}},"updaters":[{"type":"PostfixExpression","operand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"i"},"lexeme":"++"}],"variables":{"type":"VariableDeclarationList","typeAnnotation":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"int"}},"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"i"},"initializer":{"type":"NumericLiteral","value":0}}]}}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"void"}}},{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"test","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":"ASYNC","block":{"type":"Block","statements":[{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"sleep"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[]}}},{"type":"ReturnStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Future"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"FunctionExpression","parameters":{"type":"FormalParameterList","args":[]},"typeParameters":null,"body":{"type":"ExpressionFunctionBody","expression":{"type":"BinaryExpression","lexeme":"+","leftOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"rightOperand":{"type":"SimpleStringLiteral","value":"sleep 1 seconds "}}}}]}}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Future"}}},{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"testWhile"},"parameters":{"type":"FormalParameterList","args":[]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":"ASYNC","block":{"type":"Block","statements":[{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"int"}},"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"i"},"initializer":{"type":"NumericLiteral","value":0}}]}},{"type":"WhileStatement","condition":{"type":"BooleanLiteral","value":true},"body":{"type":"Block","statements":[{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"print"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"testWhile "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"i"}},{"type":"InterpolationString","value":"  "},{"type":"InterpolationExpression","expression":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"0000000"}]}}}},{"type":"InterpolationString","value":""}]}]}}},{"type":"IfStatement","condition":{"type":"BinaryExpression","lexeme":">","leftOperand":{"type":"PrefixExpression","lexeme":"++","operand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"i"}},"rightOperand":{"type":"NumericLiteral","value":5}},"thenStatement":{"type":"BreakStatement"},"elseStatement":null}]}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"void"}}}]},{"type":"ClassDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":true,"name":"_DvmFIXRegister"},"isAbstract":false,"members":[]}],"directives":[{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"dart:io"}},{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"package:ast_test/dvm.dart"}}]}
""");
  // test11.testFor();
  // print("Test11().testFor();");
  // dvm.execute("Test11", "testFor", {});
  // print("""dvm.execute("Test11", "testFor", {});""");
  // test11.testWhile();
  // print("Test11().testWhile();");
  dvm.execute("Test11", "testWhile", {});
  print("""dvm.execute("Test11", "testWhile", {});""");
}
