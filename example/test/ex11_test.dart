import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

part 'ex11_test.g.dart';

//BUG WITH ABSTRACT WITH NO PROPS

abstract class $$A {}

abstract class $B implements $$A {
  int get a;
}

@CopyWithE()
abstract class A extends $$A {}

@CopyWithE()
class B extends $B implements A {
  final int a;
  B({
    @required this.a,
  }) : assert(a != null);
}