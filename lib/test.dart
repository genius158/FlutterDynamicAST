import 'dvm.dart';
import 'default_register.dart';
import 'test2.dart';

/// [test.dart] 测试
/// Create by yanxianwei
/// Date: 2022-03-08
///
class Test {
  Future<List> asyncTest() async {
    DefaultRegister.instance.toString();
    var res= await test(2, 3);
    return  res;
  }

  Future<List> test(a, int b) async {
    var list = [];
    list.add(111);
    list.add(a + b);
    print(list);
    return list;
  }

  void switchCase(Map a) {
    var aa = a[0] == 1 ? (2 + 3 * 2) : (3 * 2);

    if (aa == 10) aa = 0;

    switch (aa) {
      case 1:
        aa = a[0];
        break;
      case 2:
        aa = 4 + 3;
        break;
    }
  }
}

int main2(String args) {
  return 3 * 3 + 2;
}


main()async {
  var test11 = Test2().test2(2);
  var test1 = Test2().test3(2);

  DVM dvm = DVM(null,"""
      {"type":"CompilationUnit","declarations":[{"type":"ClassDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Test2"},"isAbstract":false,"members":[{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"int"}},"name":"num","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":null,"block":{"type":"Block","statements":[{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"sum"},"initializer":{"type":"BinaryExpression","lexeme":"+","leftOperand":{"type":"BinaryExpression","lexeme":"+","leftOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"},"rightOperand":{"type":"BinaryExpression","lexeme":"*","leftOperand":{"type":"NumericLiteral","value":3},"rightOperand":{"type":"NumericLiteral","value":3}}},"rightOperand":{"type":"BinaryExpression","lexeme":"*","leftOperand":{"type":"DoubleLiteral","value":2.5},"rightOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"}}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"double"}},"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"sum2"},"initializer":{"type":"BinaryExpression","lexeme":"*","leftOperand":{"type":"NumericLiteral","value":5},"rightOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"sum"}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"dynamic"}},"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res"},"initializer":{"type":"ConditionalExpression","condition":{"type":"BinaryExpression","lexeme":"==","leftOperand":{"type":"BinaryExpression","lexeme":"%","leftOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"sum2"},"rightOperand":{"type":"NumericLiteral","value":2}},"rightOperand":{"type":"NumericLiteral","value":0}},"thenExpression":{"type":"PrefixExpression","lexeme":"-","operand":{"type":"NumericLiteral","value":1}},"elseExpression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"sum2"}}}]}},{"type":"ReturnStatement","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res"}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"dynamic"}}},{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"int"}},"name":"num","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":null,"block":{"type":"Block","statements":[{"type":"IfStatement","condition":{"type":"BinaryExpression","lexeme":"==","leftOperand":{"type":"BinaryExpression","lexeme":"%","leftOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"},"rightOperand":{"type":"NumericLiteral","value":2}},"rightOperand":{"type":"NumericLiteral","value":0}},"thenStatement":{"type":"Block","statements":[{"type":"ReturnStatement","expression":{"type":"BinaryExpression","lexeme":"*","leftOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"},"rightOperand":{"type":"NumericLiteral","value":2}}}]},"elseStatement":{"type":"Block","statements":[{"type":"ReturnStatement","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"num"}}]}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"dynamic"}}}]}],"directives":[]}
      """);

  var test = dvm.execute("Test2", "test3", {"num": 2});
  print("test test test3 11: $test1   22: $test");

  var test22 = dvm.execute("Test2", "test2", {"num": 2});
  print("test test test2 11: $test11   22: $test22");
}
