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
