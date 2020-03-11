import 'package:analyzer_models/analyzer_models.dart';
import 'package:copy_with_e_generator/src/helpers.dart';

String createCopyWith(
  ClassDef extType,
  List<ClassDef> types,
) {
  var sb = StringBuffer();
  sb.writeln("//" + extType.name);
  sb.writeln("//" + types.map((e) => e.name + "|" + e.baseTypes.toString()).toList().toString());
  var types2 = orderTypes(extType, types);

  sb.writeln("//" + types2.map((e) => e.name).toList().toString());
  sb.writeln(getExtensionDef(extType.name) + "{");
  sb.writeln(getCopyWithSignature(extType.name, extType.fields, extType.generics) + "{");

  types2 //
      .where((x) => !x.isAbstract) //
      .forEach((type) {
    sb.writeln("if (this is ${type.name}) {");
    sb.writeln("return ${type.name}(");
//    sb.writeln("//extType:" + extType.fields.map((e) => "${e.name}|${e.type}").toList().toString());
//    sb.writeln("//type:" + type.fields.map((e) => "${e.name}|${e.type}").toList().toString());
    sb.writeln(getConstructorLines(extType, type) + ",");
    sb.writeln(");}");
  });

  sb.writeln("throw Exception();");
  sb.writeln("}}");

  return sb.toString();
}
