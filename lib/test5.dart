import 'dvm.dart';

/// [test.dart] 测试
/// Create by yanxianwei
/// Date: 2022-03-08
///
class Test5 {
  Map test(String test) {
    var map = {};
    map["22222"] = 22222;
    map["test"] = test;
    map["12.2"] = 12.2;
    map.addAll({"aaaaa": "9999", "bbbbb": 121212});
    return map;
  }

  test2(list, String test) {
    list.add(22222);
    list.add(test);
    list.add(12.2);
    list[0] = 1111111;

    list.addAll(["8888", "9999"]);
    print("list list $list");
  }
}

// TODO ======== GENERATOR_BY_DVM_FIX START ========

final DVM dvm = DVM(null, """
      {"type":"CompilationUnit","declarations":[{"type":"ClassDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Test5"},"isAbstract":false,"members":[{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"test","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":null,"block":{"type":"Block","statements":[{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"map"},"initializer":{"type":"SetOrMapLiteral","isMap":false,"isSet":false,"elements":[]}}]}},{"type":"ExpressionStatement","expression":{"type":"AssignmentExpression","lexeme":"=","leftHandSide":{"type":"IndexExpression","index":{"type":"SimpleStringLiteral","value":"22222"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"map"}},"rightHandSide":{"type":"NumericLiteral","value":22222}}},{"type":"ExpressionStatement","expression":{"type":"AssignmentExpression","lexeme":"=","leftHandSide":{"type":"IndexExpression","index":{"type":"SimpleStringLiteral","value":"test"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"map"}},"rightHandSide":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"}}},{"type":"ExpressionStatement","expression":{"type":"AssignmentExpression","lexeme":"=","leftHandSide":{"type":"IndexExpression","index":{"type":"SimpleStringLiteral","value":"12.2"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"map"}},"rightHandSide":{"type":"DoubleLiteral","value":12.2}}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"addAll"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"map"},"argumentList":{"type":"ArgumentList","arguments":[{"type":"SetOrMapLiteral","isMap":false,"isSet":false,"elements":[{"type":"MapLiteralEntry","value":{"type":"SimpleStringLiteral","value":"9999"},"key":{"type":"SimpleStringLiteral","value":"aaaaa"}},{"type":"MapLiteralEntry","value":{"type":"NumericLiteral","value":121212},"key":{"type":"SimpleStringLiteral","value":"bbbbb"}}]}]}}},{"type":"ReturnStatement","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"map"}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Map"}}},{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":null,"name":"list","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"}},{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"test","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":null,"block":{"type":"Block","statements":[{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"add"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"},"argumentList":{"type":"ArgumentList","arguments":[{"type":"NumericLiteral","value":22222}]}}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"add"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"},"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"}]}}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"add"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"},"argumentList":{"type":"ArgumentList","arguments":[{"type":"DoubleLiteral","value":12.2}]}}},{"type":"ExpressionStatement","expression":{"type":"AssignmentExpression","lexeme":"=","leftHandSide":{"type":"IndexExpression","index":{"type":"NumericLiteral","value":0},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"}},"rightHandSide":{"type":"NumericLiteral","value":1111111}}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"addAll"},"target":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"},"argumentList":{"type":"ArgumentList","arguments":[{"type":"ListLiteral","elements":[{"type":"SimpleStringLiteral","value":"8888"},{"type":"SimpleStringLiteral","value":"9999"}]}]}}},{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"print"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"list list "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"list"}},{"type":"InterpolationString","value":""}]}]}}}]}},"returnType":null}]}],"directives":[{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"dvm.dart"}}]}
      """);

// class _DvmFIXRegister {
//   final Map<String, Function> funcMap = {
//     "addAll@1": (map, args) => {map.addAll(args[0])},
//     "add@1": (map, args) => {map.add(args[0])},
//   };
// }

// TODO ======== GENERATOR_BY_DVM_FIX STOP ========

main() {
  var test4 = Test5();
  var t4 = test4.test("cccccc");
  var list1 = [];
  var t42 = test4.test2(list1, "cccccc");
  var t5 = dvm.execute("Test5", "test", {"test": "cccccc"});
  var list2 = [];
  var t52 = dvm.execute("Test5", "test2", {"list": list2, "test": "cccccc"});
}
