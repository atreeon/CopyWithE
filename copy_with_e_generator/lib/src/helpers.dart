import 'package:copy_with_e_generator/src/classes.dart';
import 'package:dartx/dartx.dart';

String getCopyWithParamList(
  List<NameType> fields,
) {
  var result = fields
      .map((x) => "${x.type} ${x.name}") //
      .joinToString(separator: ", ");

  return result.toString();
}

String getCopyWithSignature(
  String className,
  List<NameType> fields,
) {
  var paramList = getCopyWithParamList(fields);

  var result = "$className cw$className({$paramList})";

  return result;
}

String getPropertySetThis(String className, String fieldName) => //
    "$fieldName: (this as $className).$fieldName";

String getPropertySet(String name) => //
    "$name: $name == null ? this.$name : $name";

String getConstructorLines(ClassDef extType, ClassDef typeType) {
  var result = typeType.fields.map((field) {
    if (extType.fields.any((x) => field.name == x.name)) {
      return getPropertySet(field.name);
    } else {
      return getPropertySetThis(typeType.name, field.name);
    }
  }).joinToString(separator: ",\n");

  return result;
}

String getExtensionDef(String className) => //
    "extension ${className}Ext on ${className}";
