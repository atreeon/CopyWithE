import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';

//see example project in github

@CopyWithE()
class Person {
  final int? age;
  final String? name;

  Person({this.age, this.name});

  String toString() => "${age.toString()}, ${name.toString()}";
}
