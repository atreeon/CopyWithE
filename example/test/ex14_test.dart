import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:test/test.dart';

part 'ex14_test.g.dart';

///OPTIONAL & NULL
///DIFFERENTIATE UNDEFINED AND NULL IN DART
///https://stackoverflow.com/questions/63928513/differentiate-undefined-and-null-in-dart

main() {
  test("1", () {
    var blah = Example(aString: "blah", anInt: 5);
    var newBlah = blah.cwExample(aString: Opt("blim"));

    expect(newBlah.toString(), "blim, 5");
  });

  test("2", () {
    var blah = Example(aString: "blah", anInt: 5);
    var newBlah = blah.cwExample(aString: Opt(null));

    expect(newBlah.toString(), "null, 5");
  });
}

@CopyWithE()
class Example {
  final String? aString;
  final int? anInt;

  Example({this.aString, this.anInt});

  String toString() => "${aString.toString()}, ${anInt.toString()}";
}
