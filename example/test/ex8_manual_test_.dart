//import 'package:test/test.dart';
//
//abstract class X {
//  int get a;
//}
//
//class Y extends X {
//  final int a;
//  Y(this.a);
//}
//
//class A<T1, T2 extends X> {
//  final T1? a;
//  final T2? b;
//  final int? c;
//
//  A({this.a, this.b, this.c});
//}
//
////the runtime type is A<int, String> & not just A
//
//extension AExt_CopyWithE on A {
//  A cwA<T1, T2 extends X>({T1 a, T2 b, int c}) {
//    if (this is A<T1, T2>) {
//      return A<T1, T2>(
//        a: a == null ? this.a : a,
//        b: b == null ? this.b : b,
//        c: c == null ? this.c : c,
//      );
//    }
//
//    throw Exception();
//  }
//}
//
//main() {
//  test("1", () {
//    var a = A(a: 5, b: Y(5), c: 2);
//
//    var copy = a.cwA(a: 9, b: Y(4), c: 1);
//
//    expect(copy.a, 9);
//    expect(copy.b.a, 4);
//    expect(copy.c, 1);
//  });
//}
