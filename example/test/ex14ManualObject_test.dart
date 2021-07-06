import 'package:test/test.dart';

///OPTIONAL & NULL
///DIFFERENTIATE UNDEFINED AND NULL IN DART
///https://stackoverflow.com/questions/63928513/differentiate-undefined-and-null-in-dart

main() {
  test("1", () {
    var blah = Example("blah", 5);
    var newBlah = blah.copyWith(aString: "blim");

    expect(newBlah.toString(), "aString: blim, anInt: 5,");
  });

  test("2", () {
    var blah = Example("blah", 5);
    var newBlah = blah.copyWith(aString: null);

    expect(newBlah.toString(), "aString: null, anInt: 5,");
  });
}

class Example {
  final String? aString;
  final int? anInt;

  Example(this.aString, this.anInt);

  Example copyWith({Object? aString = notSet, Object? anInt = notSet}) {
    return Example(
      aString == notSet ? this.aString : aString as String?,
      anInt == notSet ? this.anInt : anInt as int?,
    );
  }

  String toString() => "aString: $aString, anInt: $anInt,";
}

const notSet = "!£%^&*()";
