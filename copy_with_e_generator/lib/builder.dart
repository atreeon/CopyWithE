import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:copy_with_e_generator/src/CopyWithEGenerator.dart';

Builder copyWithEBuilder(BuilderOptions options) =>
SharedPartBuilder([CopyWithEGenerator()], 'copy_with_e_');
