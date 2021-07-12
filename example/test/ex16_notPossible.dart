///CLONEABLE COPY WITH
///NOT POSSIBLE
///1. can't set final fields
///2. could create a cloneable abstract class but can't access it outside different files


//import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
//import 'package:test/test.dart';
//import 'package:value_t2_annotation/value_t2_annotation.dart';
//
//part 'ex16_test.g.dart';
//

//
//main() {
//  test("1", () {
//    var blah = Example(a: "blah", b: 5);
//    var newBlah = blah.cwExample(a: Opt("blim"));
//
//    expect(newBlah.toString(), "blim, 5");
//  });
//
//  test("2", () {
//    var blah = Example(a: "blah", b: 5);
//    var newBlah = blah.cwExample(a: Opt(null));
//
//    expect(newBlah.toString(), "null, 5");
//  });
//}
//
//@CopyWithE()
//class A implements Cloneable_A {
//  final String? a;
//
//  A({this.a});
//
//  Cloneable_A clone_A({required String? a}) {
//    return this.clone_A(a: a);
//  }
//}
//
//abstract class Cloneable_A {
//  Cloneable_A clone_A({required String? a});
//}
//
//@CopyWithE()
//class B implements A, Cloneable_B {
//  final int? a;
//  final String? b;
//
//  B({this.b, this.a});
//
//  Cloneable_B clone_B({required String? b}) {
//    return this.clone_B(b: b);
//  }
//}
//
//abstract class Cloneable_B {
//  Cloneable_B clone_B({required String? b});
//}
