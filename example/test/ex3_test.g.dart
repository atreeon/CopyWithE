// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex3_test.dart';

// **************************************************************************
// CopyWithEGenerator
// **************************************************************************

extension HasAgeExt on HasAge {
  HasAge cwHasAge({int age}) {
    switch (this.runtimeType) {
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
      default:
        throw Exception();
    }
  }
}

extension HasNameExt on HasName {
  HasName cwHasName({String name}) {
    switch (this.runtimeType) {
      case Person:
        return Person(
          age: (this as Person).age,
          name: name == null ? this.name : name,
        );
      case Employee:
        return Employee(
          age: (this as Employee).age,
          name: name == null ? this.name : name,
        );
      default:
        throw Exception();
    }
  }
}
