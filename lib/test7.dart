/// [test.dart] 测试
/// Create by yanxianwei
/// Date: 2022-03-08
///
class Test7 {
  void test() {
    Future future = Future.value(1);
    future = future.then((value) => 4);
    future = future.then((value) => 5);
    future = future.then((value) => 6);
    future.then((value)async => print("future future  $value")).then((value) => null);
  }
}

main() {
  Test7().test();
}
