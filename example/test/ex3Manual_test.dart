////One concrete class has two interfaces both
////  of which have copyWith extension methods
////  so we name our copyWith cw[ClassName]?
//
//import 'package:test/test.dart';
//
//main() {
//  test("1", () {
//    var bob = Person(age: 5, name: "bob");
//    var rob = Person(age: 9, name: "rob");
//    var hasAges = <HasAge>[bob, rob];
//    var result = hasAges.map((x) => x.cwHasAge(age: 3).age).toList();
//
//    expect(result.toString(), "[3, 3]");
//  });
//}
//
//abstract class HasAge {
//  int get age;
//}
//
//abstract class HasName {
//  String get name;
//}
//
//class Person implements HasAge, HasName {
//  final int age;
//  final String name;
//
//  Person({this.age, this.name});
//}
//
//extension HasAgeExt on HasAge {
//  HasAge cwHasAge(int newAge) {
//    switch (this.runtimeType) {
//      case Person:
//        return Person(newAge, (this as Person).name);
//      default:
//        throw Exception();
//    }
//  }
//}
//
//extension HasNameExt on HasName {
//  HasName cwHasName(String newName) {
//    switch (this.runtimeType) {
//      case Person:
//        return Person((this as Person).age, newName);
//      default:
//        throw Exception();
//    }
//  }
//}
