//abstract copywith on an interface implemented on two classes

import 'package:test/test.dart';

main() {
  test("1", () {
    var bob = Person(age: 5, name: "bob");
    var rob = Employee(age: 9, name: "rob");
    var hasAges = <HasAge>[bob, rob];
    var result = hasAges.map((x) => x.cwHasAge(age: 3).age).toList();

    expect(result.toString(), "[3, 3]");
  });
}

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

extension HasAgeExt on HasAge {
  HasAge cwHasAge({int age}) {
    switch (this.runtimeType) {
      case Person:
        return Person(
          age: age == null ? this.age : age,
          name: (this as Person).name,
        );
      case Employee:
        return Employee(
          age: age == null ? this.age : age,
          name: (this as Employee).name,
        );
      default:
        throw Exception();
    }
  }
}
