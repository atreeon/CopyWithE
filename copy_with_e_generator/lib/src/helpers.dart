import 'package:copy_with_e_generator/src/classes.dart';
import 'package:dartx/dartx.dart';

String getCopyWithParamList(
  List<NameType> fields,
  List<GenericType> generics,
) {
  return fields
      .map((e) => "${e.type} ${e.name}") //
      .joinToString(separator: ", ");
}

String getCopyWithSignature(
  String className,
  List<NameType> fields,
  List<GenericType> generics,
) {
  var paramList = getCopyWithParamList(fields, generics);

  var genericList = getGenericParams(generics);

  var result = "$className cw$className${genericList}({$paramList})";

  return result;
}

String getGenericParams(List<GenericType> generics) {
  if (generics.isEmpty) //
    return "";

  var genericList = generics.map((e) {
    if (e.baseType == null) {
      return e.name;
    }

    return "${e.name} extends ${e.baseType}";
  }).joinToString(separator: ", ");
  return "<$genericList>";
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
    "extension ${className}Ext_CopyWithE on ${className}";
