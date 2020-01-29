import 'package:copy_with_e_generator/src/classes.dart';
import 'package:copy_with_e_generator/src/createCopyWith.dart';
import 'package:test/test.dart';

void main() {
  group("createCopyWith", () {
    test("1", () {
      var extType = ClassDef(false, "Person", [
        NameType("age", "int"),
        NameType("name", "String"),
      ]);

      var result = createCopyWith(extType, []).trim();

      var expected = """extension PersonExt on Person{
Person cwPerson({int age, String name}){
switch (this.runtimeType){
case Person:
return Person(
age: age == null ? this.age : age,
name: name == null ? this.name : name,
);
default: throw Exception();
}}}""";

      expect(result, expected);
    });

    test("2", () {
      var extType = ClassDef(true, "HasAge", [
        NameType("age", "int"),
      ]);

      var result = createCopyWith(extType, [
        ClassDef(false, "Person", [
          NameType("age", "int"),
          NameType("name", "String"),
        ]),
        ClassDef(false, "Employee", [
          NameType("age", "int"),
          NameType("name", "String"),
        ]),
      ]).trim();

      var expected = """extension HasAgeExt on HasAge{
HasAge cwHasAge({int age}){
switch (this.runtimeType){
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
default: throw Exception();
}}}""";

      expect(result, expected);
    });
  });
}
