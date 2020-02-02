// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex1_test.dart';

// **************************************************************************
// CopyWithEGenerator
// **************************************************************************

//RULES: 1 all subtypes must be in same file or be passed in
extension PersonExt on Person {
  Person cwPerson({int age, dynamic s, String name}) {
    switch (this.runtimeType) {
      case Person:
        return Person(
          age: age == null ? this.age : age,
          s: s == null ? this.s : s,
          name: name == null ? this.name : name,
        );
      default:
        throw Exception();
    }
  }
}
