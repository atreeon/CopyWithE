import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:test/test.dart';

part 'ex10x_test.g.dart';

//IS THE ORDER CORRECT, BUG IN VALUET2

abstract class $A {
  String get a;
}

abstract class $B implements $A {
  int get b;
}

abstract class $C implements $B {
  bool get c;
}

main() {
  test("1", () {
    var a = A(a: "A");
    var b = B(a: "A", b: 1);
    var c = C(a: "A", b: 1, c: true);

    var a1 = a.cwA(a: Opt("Aa1"));
    expect(a1.a, "Aa1");

    var b1 = b.cwA(a: Opt("Ab1"));
    expect(b1.a, "Ab1");
    expect((b1 as B).b, 1);

    var b2 = b.cwB(a: Opt("Ab2"), b: Opt(2));
    expect(b2.a, "Ab2");
    expect(b2.b, 2);

    var c1 = c.cwA(a: Opt("Ac1"));
    expect(c1.a, "Ac1");
    expect((c1 as C).b, 1);
    expect((c1).c, true);

    var c2 = c.cwB(a: Opt("Ac1"), b: Opt(3));
    expect(c2.a, "Ac1");
    expect(c2.b, 3);
    expect((c2 as C).c, true);

    var c3 = c.cwC(a: Opt("Ac1"), b: Opt(3), c: Opt(false));
    expect(c3.a, "Ac1");
    expect(c3.b, 3);
    expect(c3.c, false);
  });
}

@CopyWithE()
class A extends $A {
  final String a;
  A({
    required this.a,
  });
}

@CopyWithE()
class B extends $B implements A {
  final String a;
  final int b;
  B({
    required this.a,
    required this.b,
  });
}

@CopyWithE()
class C extends $C implements B {
  final String a;
  final int b;
  final bool c;
  C({
    required this.a,
    required this.b,
    required this.c,
  });
}
