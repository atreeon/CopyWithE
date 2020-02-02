import 'package:copy_with_e_annotation/CopyWithE.dart';
import 'package:test/test.dart';

part 'ex1_test.g.dart';

@CopyWithE()
class Person {
  final int age;s
  final String name;

  Person({this.age, this.name});

  String toString() => "${age.toString()}, ${name.toString()}";
}

main() {
  test("1", () {
    var bob = Person(age: 5, name: "bob");
    var result = bob.cwPerson(age: 6, name: "bobby");
    expect(result.toString(), "6, bobby");
  });
}