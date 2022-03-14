# FlutterDynamicAST

flutter 动态执行 ast 示例

## 生成 ast

- 生成 lib下的test3.dart dart simple_ast.dart -f test3.dart

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


## hotfix test ([test4.dart](lib/test4.dart))