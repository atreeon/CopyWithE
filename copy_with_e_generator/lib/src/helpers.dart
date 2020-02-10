import 'package:copy_with_e_generator/src/classes.dart';
import 'package:dartx/dartx.dart';

import 'adiHelpers.dart';

String getCopyWithParamList(
  List<NameType> fields,
  List<GenericType> generics,
) {
  var result = fields.where((x) {
    //<T> || T

    //we are finding T inside TPet and then rejecting it because it doesn't have a baseType
    //how do I guard against that!

    var matchingGeneric = generics.firstWhere(
        (g) => //
            x.type == g.name || x.type.contains("<${g.name}>"),
        orElse: () => null);

    if (matchingGeneric == null || matchingGeneric.baseType.isNotNullOrEmpty()) //
      return true;

    return false;
  }).toList();
  var result2 = result.map((x) {
    var matchingGeneric = generics.firstWhere(
        (g) => //
            x.type == g.name || x.type.contains("<${g.name}>"),
        orElse: () => null);

    if (matchingGeneric == null) {
      return "${x.type} ${x.name}";
    }

    var type = x.type.replaceFirst(matchingGeneric.name, matchingGeneric.baseType);

    return "${type} ${x.name}";
  }) //
      .joinToString(separator: ", ");

  return result2.toString();
}

String getCopyWithSignature(
  String className,
  List<NameType> fields,
  List<GenericType> generics,
) {
  var paramList = getCopyWithParamList(fields, generics);

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
    "extension ${className}Ext_CopyWithE on ${className}";
