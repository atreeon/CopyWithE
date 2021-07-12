import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';

part 'ex15_test.g.dart';

///GENERIC NAMES MUST BE THE SAME BETWEEN INHERITED CLASSES

@CopyWithE()
abstract class A<Ta, Tb> {
  Ta get x;
  Tb get y;
}

@CopyWithE()
class B<Ta, Tb> implements A<Ta, Tb> {
  final Ta x;
  final Tb y;
  final String z;

  B({
    required this.x,
    required this.y,
    required this.z,
  });
}
