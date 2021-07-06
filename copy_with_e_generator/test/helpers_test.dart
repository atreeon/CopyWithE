// ignore: import_of_legacy_library_into_null_safe
import 'package:copy_with_e_generator/src/helpers.dart';
import 'package:generator_common/NameType.dart';
import 'package:generator_common/classes.dart';
import 'package:test/test.dart';

void main() {
  group("getCopyWithParamList", () {
    test("1a", () {
      var fields = [
        NameTypeClassComment("age", "int", null),
        NameTypeClassComment("name", "String?", null),
      ];

      var result = getCopyWithParamList(fields, []);

      expect(result, "Opt<int>? age, Opt<String?>? name");
    });

    test("2a generic", () {
      var result = getCopyWithParamList(
        [
          NameTypeClassComment("id", "T", null),
          NameTypeClassComment("name", "String", null),
          NameTypeClassComment("pets", "List<TPet>", null),
        ],
        [
          GenericsNameType("TPet", "Pet"),
          GenericsNameType("T", null),
        ],
      );

      expect(result, "Opt<T>? id, Opt<String>? name, Opt<List<TPet>>? pets");
    });

    test("3a generic (order of generics caused a bug because T was found inside TPet!)", () {
      var result = getCopyWithParamList(
        [
          NameTypeClassComment("id", "T", null),
          NameTypeClassComment("name", "String", null),
          NameTypeClassComment("pets", "List<TPet>", null),
        ],
        [
          GenericsNameType("T", null),
          GenericsNameType("TPet", "Pet"),
        ],
      );

      expect(result, "Opt<T>? id, Opt<String>? name, Opt<List<TPet>>? pets");
    });

    test("4a null safety", () {
      var fields = [
        NameType("age", "int"),
        NameType("name", "String?"),
      ];

      var result = getCopyWithParamList(fields, []);

      expect(result, "Opt<int>? age, Opt<String?>? name");
    });
  });

  group("getCopyWithSignature", () {
    test("1b", () {
      var result = getCopyWithSignature(
        "Person",
        [
          NameType("age", "int"),
          NameType("name", "String"),
        ],
        [],
      );

      expect(result, "Person cwPerson({Opt<int>? age, Opt<String>? name})");
    });

    test("2b", () {
      var result = getCopyWithSignature(
        "A",
        [
          NameType("a", "T1"),
          NameType("b", "T2"),
          NameType("c", "int"),
        ],
        [
          GenericsNameType("T1", null),
          GenericsNameType("T2", null),
        ],
      );

      expect(result, "A cwA<T1, T2>({Opt<T1>? a, Opt<T2>? b, Opt<int>? c})");
    });

    test("3b", () {
      var result = getCopyWithSignature(
        "A",
        [
          NameType("a", "T1"),
          NameType("b", "T2"),
          NameType("c", "int"),
        ],
        [
          GenericsNameType("T1", null),
          GenericsNameType("TPet", "Pet"),
        ],
      );

      expect(result, "A cwA<T1, TPet extends Pet>({Opt<T1>? a, Opt<T2>? b, Opt<int>? c})");
    });
  });

  group("getPropertySet", () {
    test("1c", () {
      var result = getPropertySet("age", "int", []);

      expect(result, "age: age == null ? this.age as int : age.value as int");
    });

    test("2c", () {
      var result = getPropertySet("age", "T1", [GenericsNameType("T1", null)]);

      expect(result, "age: age == null ? this.age as T1 : age.value as T1");
    });
  });

  group("getConstructorLines", () {
    test("1d - simple", () {
      var result = getConstructorLines(
        ClassDef(false, "Person", [NameTypeClassComment("age", "int", null), NameTypeClassComment("name", "String?", null)], [], []),
        ClassDef(false, "Person", [NameTypeClassComment("age", "int", null), NameTypeClassComment("name", "String?", null)], [], []),
        [],
      );

      expect(
          result,
          """age: age == null ? this.age as int : age.value as int,
name: name == null ? this.name as String? : name.value as String?"""
              .trim());
    });

    test("2d - on other type", () {
      var result = getConstructorLines(
        ClassDef(true, "HasAge", [NameTypeClassComment("age", "int", null)], [], []),
        ClassDef(false, "Person", [NameTypeClassComment("age", "int", null), NameTypeClassComment("name", "String?", null)], [], []),
        [],
      );

      expect(
          result,
          """age: age == null ? this.age as int : age.value as int,
name: (this as Person).name as String?"""
              .trim());
    });

    test("3d - generics", () {
      var result = getConstructorLines(
        ClassDef(false, "Person", [NameTypeClassComment("age", "int", null), NameTypeClassComment("data", "T?", null)], [], []),
        ClassDef(false, "Person", [NameTypeClassComment("age", "int", null), NameTypeClassComment("data", "T?", null)], [], []),
        [],
      );

      expect(
          result,
          """age: age == null ? this.age as int : age.value as int,
data: data == null ? this.data as T? : data.value as T?"""
              .trim());
    });
  });

  group("orderTypes", () {
    test("1e", () {
      var class_ = ClassDef(false, "Employee", [], [], ["Person"]);
      var types = [
        ClassDef(false, "Thing", [], [], [""]),
        ClassDef(false, "Cleaner", [], [], ["Employee", "HasAge"]),
        ClassDef(false, "Person", [], [], ["Thing"]),
      ];

      var result = orderTypes(class_, types).map((e) => e.name).toList();

      expect(result.toString(), "[Cleaner, Employee, Person, Thing]");
    });

    test("2e", () {
      var class_ = ClassDef(false, "A", [], [], []);
      var types = [
        ClassDef(false, "B", [], [], ["A"]),
        ClassDef(false, "C", [], [], ["B"]),
      ];

      var result = orderTypes(class_, types).map((e) => e.name).toList();

      expect(result.toString(), "[C, B, A]");
    });

    test("3e - was a bug", () {
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
    test("1f normalc", () {
      var result = getConstructorName("MyClass");
      expect(result, "MyClass");
    });

    test("2f privatec", () {
      var result = getConstructorName("MyClass_");

      expect(result, "MyClass_._");
    });
  });
}
