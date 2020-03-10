import 'package:copy_with_e_generator/src/classes.dart';
import 'package:copy_with_e_generator/src/helpers.dart';
import 'package:test/test.dart';

void main() {
  group("getCopyWithParamList", () {
    test("1", () {
      var fields = [
        NameType("age", "int"),
        NameType("name", "String"),
      ];

      var result = getCopyWithParamList(fields, []);

      expect(result, "int age, String name");
    });

    test("2 generic", () {
      var result = getCopyWithParamList(
        [
          NameType("id", "T"),
          NameType("name", "String"),
          NameType("pets", "List<TPet>"),
        ],
        [
          GenericType("TPet", "Pet"),
          GenericType("T", null),
        ],
      );

      expect(result, "T id, String name, List<TPet> pets");
    });

    test("3 generic (order of generics caused a bug because T was found inside TPet!)", () {
      var result = getCopyWithParamList(
        [
          NameType("id", "T"),
          NameType("name", "String"),
          NameType("pets", "List<TPet>"),
        ],
        [
          GenericType("T", null),
          GenericType("TPet", "Pet"),
        ],
      );

      expect(result, "T id, String name, List<TPet> pets");
    });
  });

  group("getCopyWithSignature", () {
    test("1", () {
      var result = getCopyWithSignature(
        "Person",
        [
          NameType("age", "int"),
          NameType("name", "String"),
        ],
        [],
      );

      expect(result, "Person cwPerson({int age, String name})");
    });

    test("2", () {
      var result = getCopyWithSignature(
        "A",
        [
          NameType("a", "T1"),
          NameType("b", "T2"),
          NameType("c", "int"),
        ],
        [
          GenericType("T1", null),
          GenericType("T2", null),
        ],
      );

      expect(result, "A cwA<T1, T2>({T1 a, T2 b, int c})");
    });

    test("3", () {
      var result = getCopyWithSignature(
        "A",
        [
          NameType("a", "T1"),
          NameType("b", "T2"),
          NameType("c", "int"),
        ],
        [
          GenericType("T1", null),
          GenericType("TPet", "Pet"),
        ],
      );

      expect(result, "A cwA<T1, TPet extends Pet>({T1 a, T2 b, int c})");
    });
  });

  group("getPropertySet", () {
    test("1", () {
      var result = getPropertySet("age");

      expect(result, "age: age == null ? this.age : age");
    });
  });

  group("getConstructorLines", () {
    test("1 - simple", () {
      var result = getConstructorLines(
        ClassDef(false, "Person", [NameType("age", "int"), NameType("name", "String")], []),
        ClassDef(false, "Person", [NameType("age", "int"), NameType("name", "String")], []),
      );

      expect(
          result,
          """
age: age == null ? this.age : age,
name: name == null ? this.name : name"""
              .trim());
    });

    test("2 - on other type", () {
      var result = getConstructorLines(
        ClassDef(true, "HasAge", [NameType("age", "int")], []),
        ClassDef(false, "Person", [NameType("age", "int"), NameType("name", "String")], []),
      );

      expect(
          result,
          """
age: age == null ? this.age : age,
name: (this as Person).name"""
              .trim());
    });
  });
}
