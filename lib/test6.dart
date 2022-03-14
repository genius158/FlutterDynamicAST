import 'dart:io';

import 'dvm.dart';

/// [test.dart] 测试
/// Create by yanxianwei
/// Date: 2022-03-08
///
class Test6 {
  Future test(String test) async {
    sleep(const Duration(milliseconds: 200));
    return Future(() => test + "sleep 1 seconds ");
  }

  test2(String str) async {
    var res1 = await test(str);
    var test2 = await test("111111111111");
    var test3 = await test("222222222222");
    return "res1: $res1   res: $test2    $test3";
  }

  test3(String str) async {
    var res1 = await test(str);
    var test2 = await test("111111111111");
    var test3 = await test("222222222222");
    return "res1: $res1   res: $test2 +  $test3  ${await test("4444444444")} ${await test("555555")}";
  }
}

class _DvmFIXRegister extends Register {
  _DvmFIXRegister(dynamic target) : super(target);
  @override
  final Map<String, Function> funcMap = {
    "test@1": (map, args) => map.test(args[0]),
  };
}

main() async {
  Test6 test6 = Test6();

  DVM dvm = DVM(_DvmFIXRegister(test6), """
      {"type":"CompilationUnit","declarations":[{"type":"ClassDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Test6"},"isAbstract":false,"members":[{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"test","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":"ASYNC","block":{"type":"Block","statements":[{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"sleep"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[]}}},{"type":"ReturnStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Future"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"FunctionExpression","parameters":{"type":"FormalParameterList","args":[]},"typeParameters":null,"body":{"type":"ExpressionFunctionBody","expression":{"type":"BinaryExpression","lexeme":"+","leftOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"rightOperand":{"type":"SimpleStringLiteral","value":"sleep 1 seconds "}}}}]}}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Future"}}},{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"str","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"str"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":"ASYNC","block":{"type":"Block","statements":[{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res1"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleIdentifier","isPrivateName":false,"name":"str"}]}}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"111111111111"}]}}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"222222222222"}]}}}}]}},{"type":"ReturnStatement","expression":{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"res1: "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res1"}},{"type":"InterpolationString","value":"   res: "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"}},{"type":"InterpolationString","value":"    "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"}},{"type":"InterpolationString","value":""}]}}]}},"returnType":null},{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"str","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"str"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":"ASYNC","block":{"type":"Block","statements":[{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res1"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleIdentifier","isPrivateName":false,"name":"str"}]}}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"111111111111"}]}}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"222222222222"}]}}}}]}},{"type":"ReturnStatement","expression":{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"res1: "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res1"}},{"type":"InterpolationString","value":"   res: "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"}},{"type":"InterpolationString","value":" +  "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"}},{"type":"InterpolationString","value":"  "},{"type":"InterpolationExpression","expression":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"4444444444"}]}}}},{"type":"InterpolationString","value":" "},{"type":"InterpolationExpression","expression":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"555555"}]}}}},{"type":"InterpolationString","value":""}]}}]}},"returnType":null}]}],"directives":[{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"dart:io"}},{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"dvm.dart"}}]}
      """);

  print("test6 test6 test6 dddd1111  ${await test6.test2("dddddddd ")}");
  var res = await dvm.execute("Test6", "test2", {"str": "dddddddd "});
  print(" Dvm test6 test6 execute ---------  $res");

  var dvmtest3 = await dvm.execute("Test6", "test3", {"str": "dddddddd "});
  print(" Dvm test6 test6 test6  $dvmtest3");
  print("test6 test6 test6  ${await test6.test3("dddddddd ")}");
}
