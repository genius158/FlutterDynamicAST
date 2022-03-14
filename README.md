# FlutterDynamicAST

flutter 动态执行 ast 示例

## 生成 ast

- 生成 lib下的test3.dart： dart simple_ast.dart -f test3.dart

## 运算相关 ([test2.dart](lib/test2.dart))

具体执行见main函数

```
dynamic test3(int num) {
    if (num % 2 == 0) {
      return num * 2;
    }else{
      return num;
    }
  }
  
//ast
{
    "type":"MethodDeclaration",
    "name":{
        "type":"SimpleIdentifier",
        "isPrivateName":false,
        "name":"test"
    },
    "parameters":{
        "type":"FormalParameterList",
        "args":[
            {
                "type":"SimpleFormalParameter",
                "paramType":{
                    "type":"TypeName",
                    "name":{
                        "type":"SimpleIdentifier",
                        "isPrivateName":false,
                        "name":"String"
                    }
                },
                "name":"test",
                "identifier":{
                    "type":"SimpleIdentifier",
                    "isPrivateName":false,
                    "name":"test"
                }
            }
        ]
    },
    "typeParameters":null,
    "body":{
        "type":"BlockFunctionBody",
        "keyword":null,
        "block":{
            "type":"Block",
            "statements":[
                {
                    "type":"VariableDeclarationStatement",
                    "variables":{
                        "type":"VariableDeclarationList",
                        "typeAnnotation":null,
                        "variables":[
                            {
                                "type":"VariableDeclarator",
                                "name":{
                                    "type":"SimpleIdentifier",
                                    "isPrivateName":false,
                                    "name":"res"
                                },
                                "initializer":{
                                    "type":"BinaryExpression",
                                    "lexeme":"+",
                                    "leftOperand":{
                                        "type":"SimpleIdentifier",
                                        "isPrivateName":false,
                                        "name":"test"
                                    },
                                    "rightOperand":{
                                        "type":"SimpleStringLiteral",
                                        "value":"test1"
                                    }
                                }
                            }
                        ]
                    }
                },
                {
                    "type":"ReturnStatement",
                    "expression":{
                        "type":"SimpleIdentifier",
                        "isPrivateName":false,
                        "name":"res"
                    }
                }
            ]
        }
    },
    "returnType":{
        "type":"TypeName",
        "name":{
            "type":"SimpleIdentifier",
            "isPrivateName":false,
            "name":"String"
        }
    }
}
```
## await 实现见([test6.dart](lib/test6.dart))
```
test3(String str) async {
  var res1 = await test(str);
  var test2 = await test("111111111111");
  var test3 = await test("222222222222");
  return "res1: $res1   res: $test2 +  $test3  ${await test("4444444444")} ${await test("555555")}";
}
  
  
main() async {
  Test6 test6 = Test6();

  DVM dvm = DVM(_DvmFIXRegister(test6), """
      {"type":"CompilationUnit","declarations":[{"type":"ClassDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Test6"},"isAbstract":false,"members":[{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"test","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":"ASYNC","block":{"type":"Block","statements":[{"type":"ExpressionStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"sleep"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[]}}},{"type":"ReturnStatement","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Future"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"FunctionExpression","parameters":{"type":"FormalParameterList","args":[]},"typeParameters":null,"body":{"type":"ExpressionFunctionBody","expression":{"type":"BinaryExpression","lexeme":"+","leftOperand":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"rightOperand":{"type":"SimpleStringLiteral","value":"sleep 1 seconds "}}}}]}}}]}},"returnType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"Future"}}},{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"str","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"str"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":"ASYNC","block":{"type":"Block","statements":[{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res1"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleIdentifier","isPrivateName":false,"name":"str"}]}}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"111111111111"}]}}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"222222222222"}]}}}}]}},{"type":"ReturnStatement","expression":{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"res1: "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res1"}},{"type":"InterpolationString","value":"   res: "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"}},{"type":"InterpolationString","value":"    "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"}},{"type":"InterpolationString","value":""}]}}]}},"returnType":null},{"type":"MethodDeclaration","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"},"parameters":{"type":"FormalParameterList","args":[{"type":"SimpleFormalParameter","paramType":{"type":"TypeName","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"String"}},"name":"str","identifier":{"type":"SimpleIdentifier","isPrivateName":false,"name":"str"}}]},"typeParameters":null,"body":{"type":"BlockFunctionBody","keyword":"ASYNC","block":{"type":"Block","statements":[{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res1"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleIdentifier","isPrivateName":false,"name":"str"}]}}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"111111111111"}]}}}}]}},{"type":"VariableDeclarationStatement","variables":{"type":"VariableDeclarationList","typeAnnotation":null,"variables":[{"type":"VariableDeclarator","name":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"},"initializer":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"222222222222"}]}}}}]}},{"type":"ReturnStatement","expression":{"type":"StringInterpolation","elements":[{"type":"InterpolationString","value":"res1: "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"res1"}},{"type":"InterpolationString","value":"   res: "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test2"}},{"type":"InterpolationString","value":" +  "},{"type":"InterpolationExpression","expression":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test3"}},{"type":"InterpolationString","value":"  "},{"type":"InterpolationExpression","expression":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"4444444444"}]}}}},{"type":"InterpolationString","value":" "},{"type":"InterpolationExpression","expression":{"type":"AwaitExpression","expression":{"type":"MethodInvocation","methodName":{"type":"SimpleIdentifier","isPrivateName":false,"name":"test"},"target":null,"argumentList":{"type":"ArgumentList","arguments":[{"type":"SimpleStringLiteral","value":"555555"}]}}}},{"type":"InterpolationString","value":""}]}}]}},"returnType":null}]}],"directives":[{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"dart:io"}},{"type":"ImportDirective","keyword":"IMPORT","uri":{"type":"SimpleStringLiteral","value":"dvm.dart"}}]}
      """);

  print("test6.test2  ${await test6.test2("dddddddd ")}");
  // 执行ast
  var res = await dvm.execute("Test6", "test2", {"str": "dddddddd "});
  print(" dvm.execute test2 ---------  $res");

  // 执行ast
  var dvmtest3 = await dvm.execute("Test6", "test3", {"str": "dddddddd "});
  print("dvm.execute test3  $dvmtest3");
  print("test6.test3  ${await test6.test3("dddddddd ")}");
}

```

## hotfix test ([test4.dart](lib/test4.dart))
```
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
```