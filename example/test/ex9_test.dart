import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:test/test.dart';

part 'ex9_test.g.dart';

//MORE COPY WITH

main() {
  test("1", () {
    var b = B(x: 1, y: "Yb", z: "Zb");

    var b1 = b.cwA(x: 2, y: "Yb1");
    expect(b1.x, 2);
    expect((b1 as B).y, "Yb1");

    var b2 = b.cwB(x: 3, y: "Yb2", z: "Zb2");
    expect(b2.x, 3);
    expect(b2.y, "Yb2");
    expect(b2.z, "Zb2");
  });
}

abstract class $$A<T1, T2> {
  T1 get x;
  T2 get y;
}

abstract class $B implements $$A<int, String> {
  String get z;
}

@CopyWithE()
abstract class A<T1, T2> extends $$A<T1, T2> {
  T1 get x;
  T2 get y;
}

@CopyWithE()
class B extends $B implements A<int, String> {
  final int x;
  final String y;
  final String z;
  B({
    required this.x,
    required this.y,
    required this.z,
  });
}
