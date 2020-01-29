// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex1_test.dart';

// **************************************************************************
// CopyWithEGenerator
// **************************************************************************

extension PersonExt on Person {
  Person cwPerson({int age, String name}) {
    switch (this.runtimeType) {
      case Person:
        return Person(
          age: age == null ? this.age : age,
          name: name == null ? this.name : name,
        );
      default:
        throw Exception();
    }
  }
}
