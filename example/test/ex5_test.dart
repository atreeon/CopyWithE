import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:test/test.dart';

import 'ex5_testExtra.dart';

part 'ex5_test.g.dart';

//AUTOMATICALLY GETS SUBTYPES IF THEY EXIST IN THE SAME FILE
// ALSO, IT GETS FROM THE TYPES PARAMETER
main() {
  test("1", () {
    var bob = Person(age: 5, name: "bob");
    var rob = Employee(age: 9, name: "rob");
    var hasAges = <HasAge2>[bob, rob];
    var result = hasAges.map((x) => x.cwHasAge2(age: 3).age).toList();

    expect(result.toString(), "[3, 3]");
  });
}

@CopyWithE([Stuff]) //[Person, Employee])
abstract class HasAge2 {
  int get age;
}

class Person implements HasAge2 {
  final int age;
  final String? name;

  Person({required this.age, this.name});
}

class Employee implements Person {
  final int age;
  final String name;

  Employee({required this.age, required this.name});
}
