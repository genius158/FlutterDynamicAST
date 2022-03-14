import 'package:ast_test/dvm.dart';

/// [test.dart] 测试
/// Create by yanxianwei
/// Date: 2022-03-08
///
class Test7 {
  void test() {
    var num = 0;
    ++num;
    num++;

    print("Test7 Test7 $num");
  }
}
main() {
  DVM dvm = DVM(null, """
  {"type":"CompilationUnit","declarations":[{"type":"ClassDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Test7"},"isAbstract":false,"members":[{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"parameters":{"type":"FormalParameterList","args":[]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":null,"block":{"type":"Block","statements":[{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"},"initializer":{"type":"NumericLiteral","value":0}}]}},{"type":"ExpressionStatement","expression":{"type":"PrefixExpression","lexeme":"++","operand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"}}},{"type":"ExpressionStatement","expression":{"type":"PostfixExpression","operand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"},"lexeme":"++"}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"print"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"Test7 Test7 "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"}},{"type":"InterpolationString","value":""}]}]}}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"void"}}}]}],"directives":[{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"package:ast_test/dvm.dart"}}]}
  """);
  Test7().test();
  dvm.execute("Test7", "test", {});
}
