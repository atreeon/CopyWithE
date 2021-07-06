import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:test/test.dart';

///Opt & NULL
///DIFFERENTIATE UNDEFINED AND NULL IN DART
///https://stackoverflow.com/questions/63928513/differentiate-undefined-and-null-in-dart

main() {
  test("1", () {
    var blah = Example(aString: "blah", anInt: 5);
    var newBlah = blah.copyWith(aString: Opt("blim"));

    expect(newBlah.toString(), "aString: blim, anInt: 5,");
  });

  test("2", () {
    var blah = Example(aString: "blah", anInt: 5);
    var newBlah = blah.copyWith(aString: Opt(null));

    expect(newBlah.toString(), "aString: null, anInt: 5,");
  });
}

class Example {
  final String? aString;
  final int? anInt;

  Example({this.aString, this.anInt});

  Example copyWith({
    Opt<String>? aString,
    Opt<int?>? anInt,
  }) {
    return Example(
      aString: aString == null ? this.aString : aString.value,
      anInt: anInt == null ? this.anInt : anInt.value,
    );
  }

  String toString() => "aString: $aString, anInt: $anInt,";
}
