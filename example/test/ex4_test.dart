import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

part 'ex4_test.g.dart';

main() {
  test("ALL FIELDS FROM MY CONCRETE EXTENDED SUPERCLASS SHOULD BE INCLUDED IN MY COPYWITH EXTENSION METHOD", () {
    var rob = Employee(age: 9, name: "rob", id: 5);
    var robEdited = rob.cwPerson(age: 3);

    expect(robEdited is Employee, true);
    expect(robEdited.toString(), "5|3|rob");
  });
}

abstract class HasAge {
  int get age;
}

@CopyWithE()
class Person implements HasAge {
  final int age;
  final String name;

  Person({
    @required this.age,
    @required this.name,
  });
}

class Employee extends Person {
  final int id;

  Employee({
    @required this.id,
    @required age,
    @required name,
  }) : super(
          age: age,
          name: name,
        );

  String toString() => "${this.id}|${this.age}|${this.name}";
}
