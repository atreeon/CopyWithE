import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:test/test.dart';

part 'ex8_test.g.dart';

abstract class X {
  int get a;
}

class Y extends X {
  final int a;
  Y(this.a);
}

@CopyWithE()
class A<T1, T2 extends X> {
  final T1? a;
  final T2? b;
  final int? c;

  A({this.a, this.b, this.c});
}

main() {
  test("1", () {
    var a = A(a: 5, b: Y(5), c: 2);

    var copy = a.cwA(a: Opt(9), b: Opt(Y(4)), c: Opt(1));

    expect(copy.a, 9);
    expect((copy.b as Y).a, 4);
    expect(copy.c, 1);
  });
}
