import 'package:test/test.dart';
//copywith on a single class (no inheritance)

main() {
  test("1", () {
    var bob = Person(age: 5, name: "bob");
    var result = bob.cwPerson(age: 6, name: "bobby");
    expect(result.toString(), "6, bobby");
  });
}

class Person {
  final int age;
  final String name;

  Person({this.age, this.name});

  String toString() => "${age.toString()}, ${name.toString()}";
}

extension PersonExt on Person {
  Person cwPerson({int age, String name}) {
    switch (this.runtimeType) {
      case Person:
        return Person(
          age: age == null ? this.age : age,
          name: name == null ? this.name : name,
        );
      default:
        throw Exception();
    }
  }
}
