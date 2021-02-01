import 'package:analyzer_models/analyzer_models.dart';
import 'package:copy_with_e_generator/src/helpers.dart';

String createCopyWith(
  ClassDef extType,
  List<ClassDef> types,
) {
  var sb = StringBuffer();
  var types2 = orderTypes(extType, types);

  if (extType.fields.isEmpty) {
    return "//no fields so not possible to create a CopyWith extension method";
  }

  sb.writeln(getExtensionDef(extType.name) + "{");
  sb.writeln(getCopyWithSignature(extType.name, extType.fields, extType.generics) + "{");

  types2 //
      .where((x) => !x.isAbstract) //
      .forEach((type) {
    var constructorName = getConstructorName(type.name);
//    sb.writeln("//${type.generics.toString()}");
//    sb.writeln("//${type.fields.toString()}");
//    sb.writeln("//${type.name.toString()}");
//    sb.writeln("//${type.isAbstract.toString()}");
//    sb.writeln("//${type.baseTypes.toString()}");
    sb.writeln("if (this is ${type.name}) {");

    sb.writeln("return ${constructorName}(");
    sb.writeln(getConstructorLines(extType, type, type.generics) + ",");
    sb.writeln(");}");
  });

  sb.writeln("throw Exception();");
  sb.writeln("}}");

  return sb.toString().replaceAll("*", "");
}

//  sb.writeln("//" + extType.name);
//  sb.writeln("//" + types.map((e) => e.name + "|" + e.baseTypes.toString()).toList().toString());
//  sb.writeln("//" + types2.map((e) => e.name).toList().toString());
//    sb.writeln("//extType:" + extType.fields.map((e) => "${e.name}|${e.type}").toList().toString());
//    sb.writeln("//type:" + type.fields.map((e) => "${e.name}|${e.type}").toList().toString());
