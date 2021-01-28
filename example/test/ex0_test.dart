import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:test/test.dart';

import 'ex4_test.dart';

part 'ex0_test.g.dart';

@CopyWithE()
class Person {
  final int age;
  final String? name;

  Person({required this.age, this.name});
}

main() {
  test("1", () {
    var bob = Person(age: 5, name: "bob");
    var result = bob.cwPerson(age: 6, name: "bobby");
    expect(result.toString(), "6, bobby");
  });
}
