import 'package:copy_with_e_generator/src/classes.dart';
import 'package:copy_with_e_generator/src/helpers.dart';

String createCopyWith(
  ClassDef extType,
  List<ClassDef> types,
) {
  var types2 = orderTypes(extType, types);

  var sb = StringBuffer();
  sb.writeln(getExtensionDef(extType.name) + "{");
  sb.writeln(getCopyWithSignature(extType.name, extType.fields, extType.generics) + "{");

  types2 //
      .where((x) => !x.isAbstract) //
      .forEach((type) {
    sb.writeln("if (this is ${type.name}) {");
    sb.writeln("return ${type.name}(");
    sb.writeln(getConstructorLines(extType, type) + ",");
    sb.writeln(");}");
  });

  sb.writeln("throw Exception();");
  sb.writeln("}}");

  return sb.toString();
}
