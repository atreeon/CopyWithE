import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:test/test.dart';

part 'ex13_test.g.dart';

//GENERICS, THE IMPLEMENTS OR EXTENDS SHOULD BE INCLUDED TOO

@CopyWithE()
abstract class A<T> {
  T get x;
}

@CopyWithE()
class B<T extends C, X> implements A<int>, C {
  final int x;

  ///Blah
  final T y;
  final String z;

  B({
    required this.x,
    required this.y,
    required this.z,
  });
  String toString() => "(B-x:$x|y:$y|z:$z)";
}

@CopyWithE()
class C {
  final String z;

  C({
    required this.z,
  });
  String toString() => "(C-z:$z)";
}

@CopyWithE()
class X {
  final String p;

  X({
    required this.p,
  });
}

@CopyWithE()
class D implements C, X {
  final String z;
  final String t;
  final String p;

  D({
    required this.z,
    required this.t,
    required this.p,
  });
  String toString() => "(C-z:$z, t:$t)";
}

main() {
  test("1", () {
    B(x: 1, y: D(z: "blah", t: "blim", p: "plop"), z: "blah");
  });
}
