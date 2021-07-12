// ignore: import_of_legacy_library_into_null_safe
import 'package:dartx/dartx.dart';
import 'package:generator_common/NameType.dart';
import 'package:generator_common/classes.dart';

class DepthClassDef {
  final int depth;
  final ClassDef class_;
  DepthClassDef(this.depth, this.class_);
}

List<ClassDef> orderTypes(ClassDef extType, List<ClassDef> types) {
  var types2 = [...types, extType];

  var depths = types2.map((e) => //
      DepthClassDef(getDepth(0, e, types2), e)).toList();

  return depths
      .sortedByDescending((element) => element.depth) //
      .map((e) => e.class_)
      .toList();
}

int getDepth(int count, ClassDef thisType, List<ClassDef> types) {
  var related = thisType.baseTypes.intersect(types.map((e) => e.name)).toList();

  if (related.length > 1) //
    return related.map((r) => getDepth(count + 1, types.firstWhere((x) => x.name == r), types)).max()!;

  if (related.length == 0) //
    return count;

  return getDepth(count + 1, types.firstWhere((x) => x.name == related[0]), types);
}

String getCopyWithParamList(
  List<NameType> fields,
  List<GenericsNameType> generics,
) {
  return fields
      .map((e) => "Opt<${e.type}>? ${e.name}") //
      .joinToString(separator: ", ");
}

String getCopyWithSignature(
  String className,
  List<NameType> fields,
  List<GenericsNameType> generics,
) {
  var paramList = getCopyWithParamList(fields, generics);

  var genericList = getGenericParams(generics);

  var result = "$className cw$className${genericList}({$paramList})";

  return result;
}

String getGenericParams(List<GenericsNameType> generics) {
  if (generics.isEmpty) //
    return "";

  var genericList = generics.map((e) {
    if (e.type == null) {
      return e.name;
    }

    return "${e.name} extends ${e.type}";
  }).joinToString(separator: ", ");
  return "<$genericList>";
}

String getPropertySetThis(String className, String fieldName, String? type, List<GenericsNameType> generics) {
  if (generics.any((x) => x.name == type)) //
    return "$fieldName: (this as $className).$fieldName";

  return "$fieldName: (this as $className).$fieldName as $type";
}


String getPropertySet(String name, String? type, List<GenericsNameType> generics) {
  if (generics.any((x) => x.name == type)) //
    return "$name: $name == null ? this.$name as $type : $name.value as $type";

  return "$name: $name == null ? this.$name as $type : $name.value as $type";
}

String getConstructorLines(ClassDef extType, ClassDef typeType, List<GenericsNameType> generics) {
  var result = typeType.fields.map((field) {
    if (extType.fields.any((x) => field.name == x.name)) {
      return getPropertySet(field.name, field.type, generics);
    } else {
      return getPropertySetThis(typeType.name, field.name, field.type, generics);
    }
  }).joinToString(separator: ",\n");

  return result;
}

String getExtensionDef(String className) => //
    "extension ${className}Ext_CopyWithE on ${className}";

String getConstructorName(String trimmedClassName) {
  return trimmedClassName[trimmedClassName.length - 1] == "_" ? "$trimmedClassName._" : trimmedClassName;
}
