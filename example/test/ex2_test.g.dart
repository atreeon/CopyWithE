// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex2_test.dart';

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
