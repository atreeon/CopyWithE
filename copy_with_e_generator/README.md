###copy_with_e

## You want to copy your object and change individual property values?

```
var bob = Person(age: 5, name: "bob");

bob.cwPerson(age: 6, name: "bobby");
```

## ... then use copy_with_e

copy_with_e is dart nullsafety compatible (and works on subclasses too unlike most implementions, see below)

##### Just put the CopyWithE annotation on the class
```
@CopyWithE()
class Person {
  final int age;
  final String name;

  Person({this.age, this.name});
}
```

##### add the dependencies

```
dependencies:
  copy_with_e_annotation: ^1.0.2-nullsafety2

dev_dependencies:
  copy_with_e_generator: ^1.0.2-nullsafety2
```

##### and build the generated code
```
pub run build_runner build
```

##### You can also copy by interface type
```
var bob = Person(age: 5, name: "bob");
var rob = Employee(age: 9, name: "rob");
var hasAges = <HasAge>[bob, rob];

//add a year to all employees & people
hasAges.map((x) => x.cwHasAge(age: 3 + 1));
```

##### ...if a class implementing an interface is in a different file you need to tell CopyWithE annotation about those classes (for classes in the same file it is automatic)
```
@CopyWithE([Person, Employee])
abstract class HasAge {
  int get age;
}
```

For more examples look at the Examples test folder in the github repository
