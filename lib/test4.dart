import 'dvm.dart';

/// [test.dart] 测试
/// Create by yanxianwei
/// Date: 2022-03-08
///
class Test4 {
  Test4() {
    //ceshi le wodet
  }

  List test(String test) {
    // TODO ======== GENERATOR_BY_DVM_FIX hotfix enable ========
    if (dvm.hotFix("Test4", "test", 1)) {
      return dvm.execute("Test4", "test", {"test": test});
    }

    var list = [];
    list.add(22222);
    list.add(test);
    list.add(12.2);
    list[0] = 1111111;

    list.addAll(["8888", "9999"]);
    return list;
  }


// TODO ======== GENERATOR_BY_DVM_FIX START ========
  final DVM dvm = DVM(null, """
      {"type":"CompilationUnit","declarations":[{"type":"ClassDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Test4"},"isAbstract":false,"members":[{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"test","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":null,"block":{"type":"Block","statements":[{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"},"initializer":{"type":"ListLiteral","elements":[]}}]}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"add"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"},"argumentList":{"type":"ArgumentList","arguments":[{"type":"NumericLiteral","value":22222}]}}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"add"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"},"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"}]}}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"add"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"},"argumentList":{"type":"ArgumentList","arguments":[{"type":"DoubleLiteral","value":12.2}]}}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"addAll"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"},"argumentList":{"type":"ArgumentList","arguments":[{"type":"ListLiteral","elements":[{"type":"SimpleStringLiteral","value":"8888"},{"type":"SimpleStringLiteral","value":"9999"}]}]}}},{"type":"ReturnStatement","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"List"}}}]}],"directives":[{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"dvm.dart"}}]}
      """);
// TODO ======== GENERATOR_BY_DVM_FIX STOP ========

}

main() {
  var test4 = Test4();
  print("original:$test4   hotfix: ${test4.test('hotfix')}");
}
