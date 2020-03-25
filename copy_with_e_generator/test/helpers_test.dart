import 'package:analyzer_models/analyzer_models.dart';
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
        ClassDef(false, "Person", [NameType("age", "int"), NameType("name", "String")], [], []),
        ClassDef(false, "Person", [NameType("age", "int"), NameType("name", "String")], [], []),
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
        ClassDef(true, "HasAge", [NameType("age", "int")], [], []),
        ClassDef(false, "Person", [NameType("age", "int"), NameType("name", "String")], [], []),
      );

      expect(
          result,
          """
age: age == null ? this.age : age,
name: (this as Person).name"""
              .trim());
    });
  });

  group("orderTypes", () {
    test("1", () {
      var class_ = ClassDef(false, "Employee", [], [], ["Person"]);
      var types = [
        ClassDef(false, "Thing", [], [], [""]),
        ClassDef(false, "Cleaner", [], [], ["Employee", "HasAge"]),
        ClassDef(false, "Person", [], [], ["Thing"]),
      ];

      var result = orderTypes(class_, types).map((e) => e.name).toList();

      expect(result.toString(), "[Cleaner, Employee, Person, Thing]");
    });

    test("2", () {
      var class_ = ClassDef(false, "A", [], [], []);
      var types = [
        ClassDef(false, "B", [], [], ["A"]),
        ClassDef(false, "C", [], [], ["B"]),
      ];

      var result = orderTypes(class_, types).map((e) => e.name).toList();

      expect(result.toString(), "[C, B, A]");
    });

    test("3 - was a bug", () {
      var class_ = ClassDef(false, "Batch_Lesson", [], [], []);
      var types = [
        ClassDef(false, "Lesson_Lectures", [], [], ["Batch_Lesson"]),
        ClassDef(false, "Batch_Staged_Lesson", [], [], ["Batch_Lesson"]),
        ClassDef(false, "Batch_Staged_Lesson_Lectures", [], [], ["Batch_Staged_Lesson", "Lesson_Lectures"]),
      ];

      var result = orderTypes(class_, types).map((e) => e.name).toList();

      expect(result.toString(), "[Batch_Staged_Lesson_Lectures, Lesson_Lectures, Batch_Staged_Lesson, Batch_Lesson]");
    });
  });

  group("getConstructorName", () {
    test("1 normalc", () {
      var result = getConstructorName("MyClass");
      expect(result, "MyClass");
    });

    test("2 privatec", () {
      var result = getConstructorName("MyClass_");

      expect(result, "MyClass_._");
    });
  });
}
