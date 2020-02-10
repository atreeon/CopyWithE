import 'package:copy_with_e_generator/src/classes.dart';
import 'package:copy_with_e_generator/src/helpers.dart';
import 'package:dartx/dartx.dart';

String createCopyWith(
  ClassDef extType,
  List<ClassDef> types,
) {
  var types2 = types.appendElement(extType);

  var sb = StringBuffer();
  sb.writeln(getExtensionDef(extType.name) + "{");
  sb.writeln(getCopyWithSignature(extType.name, extType.fields, extType.generics) + "{");
  sb.writeln("switch (this.runtimeType)" + "{");

  types2
      .where((x) => !x.isAbstract) //
      .sortedByDescending((x) => x.name) //TODO: this needs to change to solve 3
      .forEach((type) {
    sb.writeln("case ${type.name}:");
    sb.writeln("return ${type.name}(");
    sb.writeln(getConstructorLines(extType, type) + ",");
    sb.writeln(");");
  });

  sb.writeln("default: throw Exception();");
  sb.writeln("}}}");

  return sb.toString();
}
