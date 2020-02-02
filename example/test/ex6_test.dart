import 'package:copy_with_e_annotation/CopyWithE.dart';
import 'package:test/test.dart';

import 'ex2_test.dart';

part 'ex6_test.g.dart';

//IF ANNOTATION IS ON AN ABSTRACT CLASS
//AND IT HAS A SUPERTYPE(s)
//WE MUST ALSO GET ALL THE FIELDS FROM THE SUPERTYPE
//AND IMPLEMENT PARAMETERS IN THE COPYWITH SIGNATURE

main() {
  test("1", () {
    var bob = Employee(id: 3, age: 5, name: "bob");
    var rob = Employee(id: 4, age: 9, name: "rob");
    var people = <IPerson>[bob, rob];
    var result = people.map((x) => x. .cwHasAge2(age: 3).age).toList();

    expect(result.toString(), "[3, 3]");
  });
}

abstract class HasAge {
  int get age;
}

@CopyWithE()
abstract class IPerson implements HasAge {
  int get id;
}

class Employee implements IPerson {
  final int id;
  final int age;
  final String name2;

  Employee({this.id, this.age, this.name2});
}
