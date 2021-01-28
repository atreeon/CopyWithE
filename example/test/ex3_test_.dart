//import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
//import 'package:test/test.dart';
//
////One concrete class has two interfaces both
////  of which have copyWith extension methods
////  so we name our copyWith cw[ClassName]?
//
//part 'ex3_test.g.dart';
//
//main() {
//  test("1", () {
//    var bob = Person(age: 5, name: "bob");
//    var rob = Employee(age: 9, name: "rob");
//    var hasAges = <HasAge>[bob, rob];
//    var hasNames = <HasName>[bob, rob];
//
//    var ages = hasAges.map((x) => x.cwHasAge(age: 3).age).toList();
//    var names = hasNames.map((x) => x.cwHasName(name: "tod").name).toList();
//
//    expect(ages.toString(), "[3, 3]");
//    expect(names.toString(), "[tod, tod]");
//  });
//}
//
//@CopyWithE([Person, Employee])
//abstract class HasAge {
//  int get age;
//}
//
//@CopyWithE([Person, Employee])
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
//class Employee implements Person {
//  final int age;
//  final String name;
//
//  Employee({this.age, this.name});
//}
