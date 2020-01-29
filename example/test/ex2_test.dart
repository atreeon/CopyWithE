import 'package:copy_with_e_annotation/CopyWithE.dart';
import 'package:test/test.dart';

part 'ex2_test.g.dart';

main() {
  test("1", () {
    var bob = Person(age: 5, name: "bob");
    var rob = Employee(age: 9, name: "rob");
    var hasAges = <HasAge>[bob, rob];
    var result = hasAges.map((x) => x.cwHasAge(age: 3).age).toList();

    expect(result.toString(), "[3, 3]");
  });
}

@CopyWithE([Person, Employee])
abstract class HasAge {
  int get age;
}

class Person implements HasAge {
  final int age;
  final String name;

  Person({this.age, this.name});
}

class Employee implements Person {
  final int age;
  final String name;

  Employee({this.age, this.name});
}
