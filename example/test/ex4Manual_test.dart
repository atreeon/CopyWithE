//One concrete class has two interfaces both
//  of which have copyWith extension methods
//  so we name our copyWith cw[ClassName]?

//a subclass implements a concrete superclass (none are abstract)

class HasAge {
  final int age;
  HasAge({this.age});
}

class Person implements HasAge {
  final int age;
  final String name;

  Person({this.age, this.name});
}

extension HasAgeExt on HasAge {
  HasAge cwHasAge({int newAge}) {
    switch (this.runtimeType) {
      case HasAge:
        return HasAge(
          age: age == null ? this.age : age,
        );
      case Person:
        return Person(
          age: age == null ? this.age : age,
          name: (this as Person).name,
        );
      default:
        throw Exception();
    }
  }
}
