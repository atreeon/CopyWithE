// ignore: import_of_legacy_library_into_null_safe
import 'package:copy_with_e_generator/src/createCopyWith.dart';
import 'package:generator_common/NameType.dart';
import 'package:generator_common/classes.dart';
import 'package:test/test.dart';

void main() {
  group("createCopyWith", () {
    test("1", () {
      var extType = ClassDef(false, "Person", [
        NameTypeClassComment("age", "int", null),
        NameTypeClassComment("name", "String?", null),
      ], [], []);

      var result = createCopyWith(extType, []).trim();

      var expected = """extension PersonExt_CopyWithE on Person{
Person cwPerson({int? age, String? name}){
if (this is Person) {
return Person(
age: age == null ? this.age as int : age as int,
name: name == null ? this.name as String? : name as String?,
);}
throw Exception();
}}""";

      expect(result, expected);
    });

    test("2", () {
      var extType = ClassDef(true, "HasAge", [
        NameTypeClassComment("age", "int", null),
      ], [], []);

      var result = createCopyWith(extType, [
        ClassDef(false, "Person", [
          NameTypeClassComment("age", "int", null),
          NameTypeClassComment("name", "String", null),
        ], [], []),
        ClassDef(false, "Employee", [
          NameTypeClassComment("age", "int", null),
          NameTypeClassComment("name", "String", null),
        ], [], []),
      ]).trim();

      var expected = """extension HasAgeExt_CopyWithE on HasAge{
HasAge cwHasAge({int? age}){
if (this is Person) {
return Person(
age: age == null ? this.age as int : age as int,
name: (this as Person).name as String,
);}
if (this is Employee) {
return Employee(
age: age == null ? this.age as int : age as int,
name: (this as Employee).name as String,
);}
throw Exception();
}}""";

      expect(result, expected);
    });

    test("3 with generics", () {
      var extType = ClassDef(true, "PetOwnerBase", [
        NameTypeClassComment("id", "T", null),
        NameTypeClassComment("name", "String", null),
        NameTypeClassComment("pets", "List<TPet>?", null),
      ], [
        GenericsNameType("T", null),
        GenericsNameType("TPet", "Pet"),
      ], []);

      var result = createCopyWith(extType, [
        ClassDef(false, "DogOwner", [
          NameTypeClassComment("id", "int", null),
          NameTypeClassComment("pets", "List<Dog>?", null),
          NameTypeClassComment("name", "String", null),
          NameTypeClassComment("dogStuff", "String", null),
        ], [], []),
        ClassDef(false, "CatOwner", [
          NameTypeClassComment("id", "int", null),
          NameTypeClassComment("pets", "List<Cat>?", null),
          NameTypeClassComment("name", "String", null),
          NameTypeClassComment("catStuff", "String", null),
        ], [], []),
      ]).trim();

      var expected = """extension PetOwnerBaseExt_CopyWithE on PetOwnerBase{
PetOwnerBase cwPetOwnerBase<T, TPet extends Pet>({T? id, String? name, List<TPet>? pets}){
if (this is DogOwner) {
return DogOwner(
id: id == null ? this.id as int : id as int,
pets: pets == null ? this.pets as List<Dog>? : pets as List<Dog>?,
name: name == null ? this.name as String : name as String,
dogStuff: (this as DogOwner).dogStuff as String,
);}
if (this is CatOwner) {
return CatOwner(
id: id == null ? this.id as int : id as int,
pets: pets == null ? this.pets as List<Cat>? : pets as List<Cat>?,
name: name == null ? this.name as String : name as String,
catStuff: (this as CatOwner).catStuff as String,
);}
throw Exception();
}}""";

      expect(result, expected);
    });

    test("4 ", () {
      var extType = ClassDef(false, "Person_", [
        NameTypeClassComment("age", "int", null),
        NameTypeClassComment("name", "String", null),
      ], [], []);

      var result = createCopyWith(extType, []).trim();

      var expected = """extension Person_Ext_CopyWithE on Person_{
Person_ cwPerson_({int? age, String? name}){
if (this is Person_) {
return Person_._(
age: age == null ? this.age as int : age as int,
name: name == null ? this.name as String : name as String,
);}
throw Exception();
}}""";

      expect(result, expected);
    });
  });
}
