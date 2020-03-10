import 'package:copy_with_e_generator/src/classes.dart';
import 'package:copy_with_e_generator/src/createCopyWith.dart';
import 'package:test/test.dart';

void main() {
  group("createCopyWith", () {
    test("1", () {
      var extType = ClassDef(false, "Person", [
        NameType("age", "int"),
        NameType("name", "String"),
      ], [], []);

      var result = createCopyWith(extType, []).trim();

      var expected = """extension PersonExt_CopyWithE on Person{
Person cwPerson({int age, String name}){
if (this is Person) {
return Person(
age: age == null ? this.age : age,
name: name == null ? this.name : name,
);}
throw Exception();
}}""";

      expect(result, expected);
    });

    test("2", () {
      var extType = ClassDef(true, "HasAge", [
        NameType("age", "int"),
      ], [], []);

      var result = createCopyWith(extType, [
        ClassDef(false, "Person", [
          NameType("age", "int"),
          NameType("name", "String"),
        ], [], []),
        ClassDef(false, "Employee", [
          NameType("age", "int"),
          NameType("name", "String"),
        ], [], []),
      ]).trim();

      var expected = """extension HasAgeExt_CopyWithE on HasAge{
HasAge cwHasAge({int age}){
if (this is Person) {
return Person(
age: age == null ? this.age : age,
name: (this as Person).name,
);}
if (this is Employee) {
return Employee(
age: age == null ? this.age : age,
name: (this as Employee).name,
);}
throw Exception();
}}""";

      expect(result, expected);
    });

    test("3 with generics", () {
      var extType = ClassDef(true, "PetOwnerBase", [
        NameType("id", "T"),
        NameType("name", "String"),
        NameType("pets", "List<TPet>"),
      ], [
        GenericType("T", null),
        GenericType("TPet", "Pet"),
      ], []);

      var result = createCopyWith(extType, [
        ClassDef(false, "DogOwner", [
          NameType("id", "int"),
          NameType("pets", "List<Dog>"),
          NameType("name", "String"),
          NameType("dogStuff", "String"),
        ], [], []),
        ClassDef(false, "CatOwner", [
          NameType("id", "int"),
          NameType("pets", "List<Cat>"),
          NameType("name", "String"),
          NameType("catStuff", "String"),
        ], [], []),
      ]).trim();

      var expected = """extension PetOwnerBaseExt_CopyWithE on PetOwnerBase{
PetOwnerBase cwPetOwnerBase<T, TPet extends Pet>({T id, String name, List<TPet> pets}){
if (this is DogOwner) {
return DogOwner(
id: id == null ? this.id : id,
pets: pets == null ? this.pets : pets,
name: name == null ? this.name : name,
dogStuff: (this as DogOwner).dogStuff,
);}
if (this is CatOwner) {
return CatOwner(
id: id == null ? this.id : id,
pets: pets == null ? this.pets : pets,
name: name == null ? this.name : name,
catStuff: (this as CatOwner).catStuff,
);}
throw Exception();
}}""";

      expect(result, expected);
    });
  });
}
