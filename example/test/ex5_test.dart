import 'package:copy_with_e_annotation/CopyWithE.dart';
import 'package:test/test.dart';

import 'ex5_testExtra.dart';

part 'ex5_test.g.dart';

//AUTOMATICALLY GETS SUBTYPES & STILL GETS FROM TYPES

main() {
  test("1", () {
    var bob = Person(age: 5, name: "bob");
    var rob = Employee(age: 9, name: "rob");
    var pap = Stuff(age: 9, name: "rob");
    var hasAges = <HasAge2>[bob, rob];
    var result = hasAges.map((x) => x.cwHasAge2(age: 3).age).toList();

    expect(result.toString(), "[3, 3]");
  });
}

@CopyWithE([Stuff, Employee]) //[Person, Employee])
abstract class HasAge2 {
  int get age;
}

class Person implements HasAge2 {
  final int age;
  final String name;

  Person({this.age, this.name});
}

class Employee implements Person {
  final int age;
  final String name;

  Employee({this.age, this.name});
}
