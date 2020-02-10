###copy_with_e

For more examples look at the github repository

Simple, just put the CopyWithE annotation on the class
```
var bob = Person(age: 5, name: "bob");
var result = bob.cwPerson(age: 6, name: "bobby");

@CopyWithE()
class Person {
  final int age;
  final String name;

  Person({this.age, this.name});

  String toString() => "${age.toString()}, ${name.toString()}";
}
```
It works on superclasses automatically
```
var bob = Person(age: 5, name: "bob");
var rob = Employee(age: 9, name: "rob");
var hasAges = <HasAge>[bob, rob];
var result = hasAges.map((x) => x.cwHasAge(age: 3).age).toList();

@CopyWithE([Person, Employee])
abstract class HasAge {
  int get age;
}

class Person implements HasAge {
  final int age;
  final String name;

  Person({this.age, this.name});
}
```
One concrete class has two interfaces both
  of which have copyWith extension methods.  It works! and that is why we name our copyWith cw[ClassName]
```
var ages = hasAges.map((x) => x.cwHasAge(age: 3).age).toList();

@CopyWithE([Person, Employee])
abstract class HasAge {
  int get age;
}

@CopyWithE([Person, Employee])
abstract class HasName {
  String get name;
}

class Person implements HasAge, HasName {
  final int age;
  final String name;

  Person({this.age, this.name});
}

class Employee implements Person {
  final int age;
  final String name;

  Employee({this.age, this.name});
}
```

Automatically gets subtypes if they exist in the same file 
 also, it gets from the types parameter
```
    var bob = Person(age: 5, name: "bob");
    var rob = Employee(age: 9, name: "rob");
    var hasAges = <HasAge2>[bob, rob];
    var result = hasAges.map((x) => x.cwHasAge2(age: 3).age).toList();

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
```

For more examples look at the Examples project in the github repository
