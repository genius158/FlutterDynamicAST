import 'dart:ffi';

import 'package:ast_test/dvm.dart';

/// [test.dart] 测试
/// Create by yanxianwei
/// Date: 2022-03-08
///
class Test10 {
  void test({int? num}) {
    print("Test10 Test10 ${num ?? 2}");
    num ??= 6;
    print("Test10 Test10 $num");
  }
}


main(){
  Test10().test();

  DVM dvm = DVM(null,
  """
  {"type":"CompilationUnit","declarations":[{"type":"ClassDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Test10"},"isAbstract":false,"members":[{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"parameters":{"type":"FormalParameterList","args":[]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":null,"block":{"type":"Block","statements":[{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"print"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"Test10 Test10 "},{"type":"InterpolationExpression","expression":{"type":"BinaryExpression","lexeme":"??","leftOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"},"rightOperand":{"type":"NumericLiteral","value":2}}},{"type":"InterpolationString","value":""}]}]}}},{"type":"ExpressionStatement","expression":{"type":"AssignmentExpression","lexeme":"??=","leftHandSide":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"},"rightHandSide":{"type":"NumericLiteral","value":6}}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"print"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"Test10 Test10 "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"}},{"type":"InterpolationString","value":""}]}]}}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"void"}}}]}],"directives":[{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"dart:ffi"}},{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"package:ast_test/dvm.dart"}}]}
  """);

  dvm.execute("Test10", "test", {});
}