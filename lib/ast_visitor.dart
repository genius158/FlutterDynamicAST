/// [ast_visitor] ast
/// Create by yanxianwei
/// Date: 2022-03-08
///
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:args/args.dart';
import 'package:pub_semver/pub_semver.dart';

void main(List<String> arguments) {
  exitCode = 0; // presume success
  final parser = ArgParser()..addFlag("file", negatable: false, abbr: 'f');

  var argResults = parser.parse(arguments);
  final paths = argResults.rest;
  if (paths.isEmpty) {
    stdout.writeln('No file found');
  } else {
    generate(paths[0]);
  }
}

class DemoAstVisitor extends GeneralizingAstVisitor<Map> {
  @override
  Map? visitNode(AstNode node) {
    //输出遍历AST Node 节点内容
    stdout.writeln("${node.runtimeType}<---->${node.toString()}");
    return super.visitNode(node);
  }
}

final FeatureSet language_2_14_4 = FeatureSet.fromEnableFlags2(
  sdkLanguageVersion: Version.parse('2.14.4'),
  flags: [],
);

//生成AST
Future generate(String path) async {
  if (path.isEmpty) {
    stdout.writeln("No file found");
  } else {
    await _handleError(path);
    if (exitCode == 2) {
      try {
        stdout.writeln('path path path: $path');

        var parseResult = parseFile(path: path, featureSet: language_2_14_4);
        var compilationUnit = parseResult.unit;

        compilationUnit.accept(DemoAstVisitor());
      } catch (e) {
        stdout.writeln('Parse file error: ${e.toString()}');
      }
    }
  }
}

Future _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
