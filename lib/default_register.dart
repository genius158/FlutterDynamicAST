import 'dvm.dart';

/// [DefaultRegister] 注册表
/// Create by yanxianwei
/// Date: 2022-03-08
///
class DefaultRegister extends Register {
  static final DefaultRegister instance = DefaultRegister();

  @override
  final funcMap = {
    "Future@1": (obj, args) => obj.add(args[0]),
    //List
    // +
    // ==
    // []
    // []=
    // add
    "add@1": (obj, args) => obj.add(args[0]),
    // addAll
    "addAll@1": (obj, args) => obj.addAll(args[0]),
    // asMap
    "asMap@0": (obj, args) => obj.asMap(),
    // cast
    "cast@0": (obj, args) => obj.cast(),
    // castFrom
    // clear
    "clear@0": (obj, args) => obj.clear(),
    // copyRange
    // fillRange
    // first
    "first@1": (obj, args) => obj.first(args[0]),
    // getRange
    "getRange@2": (obj, args) => obj.getRange(args[0], args[1]),
    // indexOf
    "indexOf@1": (obj, args) => obj.indexOf(args[0]),
    // indexWhere
    // insert
    // insertAll
    // last
    // lastIndexOf
    // lastIndexWhere
    // length
    // length
    // filled
    // from
    // generate
    // of
    // unmodifiable
    // remove
    "remove@1": (obj, args) => obj.remove(args[0]),
    // removeAt
    "removeAt@1": (obj, args) => obj.removeAt(args[0]),
    // removeLast
    "removeLast@0": (obj, args) => obj.removeLast(),
    "print@1": (args) => print(args[0]),
    // removeRange
    // removeWhere
    // replaceRange
    // retainWhere
    // reversed
    // setAll
    // setRange
    // shuffle
    // sort
    // sublist
    // writeIterable
  };

  DefaultRegister() : super(null) {
    funcMap["Future@1"] = (obj, args) => obj.add(args[0]);

    //List
    // +
    // ==
    // []
    // []=
    // add
    funcMap["add@1"] = (obj, args) => obj.add(args[0]);
    // addAll
    funcMap["addAll@1"] = (obj, args) => obj.addAll(args[0]);
    // asMap
    funcMap["asMap@0"] = (obj, args) => obj.asMap();
    // cast
    funcMap["cast@0"] = (obj, args) => obj.cast();
    // castFrom
    // clear
    funcMap["clear@0"] = (obj, args) => obj.clear();
    // copyRange
    // fillRange
    // first
    funcMap["first@1"] = (obj, args) => obj.first(args[0]);
    // getRange
    funcMap["getRange@2"] = (obj, args) => obj.getRange(args[0], args[1]);
    // indexOf
    funcMap["indexOf@1"] = (obj, args) => obj.indexOf(args[0]);
    // indexWhere
    // insert
    // insertAll
    // last
    // lastIndexOf
    // lastIndexWhere
    // length
    // length
    // filled
    // from
    // generate
    // of
    // unmodifiable
    // remove
    funcMap["remove@1"] = (obj, args) => obj.remove(args[0]);
    // removeAt
    funcMap["removeAt@1"] = (obj, args) => obj.removeAt(args[0]);
    // removeLast
    funcMap["removeLast@0"] = (obj, args) => obj.removeLast();
    funcMap["print@1"] = (args) => print(args[0]);
    // removeRange
    // removeWhere
    // replaceRange
    // retainWhere
    // reversed
    // setAll
    // setRange
    // shuffle
    // sort
    // sublist
    // writeIterable
  }
}

main() {
  var addAll = DefaultRegister.instance.funcMap["addAll@1"];
  var list = [];
  addAll!(list, [
    ["qweewe", "121212"]
  ]);
  var add = DefaultRegister.instance.funcMap["add@1"];

  add!(list, [
    999999
  ]);
}
