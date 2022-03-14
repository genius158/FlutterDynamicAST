import 'dvm.dart';

/// [test.dart] 测试
/// Create by yanxianwei
/// Date: 2022-03-08
///
class Test2 {
  dynamic test2(int num) {
    var sum = num + 3 * 3 + 2.5 * num;

    double sum2 = 5 * sum;

    dynamic res = sum2 % 2 == 0 ? -1 : sum2;

    return res;
  }

  dynamic test3(int num) {
    if (num % 2 == 0) {
      return num * 2;
    }else{
      return num;
    }
  }
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
