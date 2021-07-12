import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
// ignore: import_of_legacy_library_into_null_safe
// ignore: import_of_legacy_library_into_null_safe
import 'package:build/src/builder/build_step.dart';
import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:copy_with_e_generator/src/createCopyWith.dart';
import 'package:dartx/dartx.dart';
import 'package:generator_common/GeneratorForAnnotationX.dart';
import 'package:generator_common/classes.dart';
import 'package:generator_common/helpers.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:source_gen/source_gen.dart';

//List<NameType> getAllFields(List<InterfaceType> interfaceTypes, ClassElement classElement) {
//  var superTypeFields = interfaceTypes //
//      .where((x) => x.element.name != "Object")
//      .flatMap((st) => st.element.fields.map((f) => //
//          NameType(f.name, f.type.toString())))
//      .toList();
//  var classFields = classElement.fields.map((f) => //
//      NameType(f.name, f.type.toString())).toList();
//
//  return (classFields + superTypeFields).distinctBy((x) => x.name).toList();
//}

class CopyWithEGenerator extends GeneratorForAnnotationX<CopyWithE> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
    List<ClassElement> allClasses,
  ) {
    var sb = StringBuffer();

    sb.writeln(//
        "//RULES: 1 all subtypes must be in same file or be passed in. 2 the types passed in must all be classes");

    var types = <ClassDef>[];
    if (!annotation.read('types').isNull) {
      types = annotation
          .read('types') //
          .listValue
          .map((x) {
        var el = x.toTypeValue()!.element;

        if (el is! ClassElement) {
          throw Exception("the list of types for the copywith def must all be classes");
        }

        return ClassDef(
          el.isAbstract,
          el.name,
          getAllFields(el.allSupertypes, el),
          el.typeParameters.map((e) => GenericsNameType(e.name, e.bound.toString())).toList(),
          [
            ...el.interfaces.map((e) => e.element.name),
            el.supertype!.element.name,
          ],
        );
      }).toList();
    }

    if (element is ClassElement) {
      var subClasses = allClasses //
          .where((x) => x.allSupertypes.any((st) => st.element.name == element.name))
          .where((x) => !types.any((t) => t.name == x.name))
          .map((x) => ClassDef(
                x.isAbstract,
                x.name,
                getAllFields(x.allSupertypes, x),
                x.typeParameters.map((e) => GenericsNameType(e.name, e.bound.toString())).toList(),
                x.interfaces.map((e) => e.element.name).toList(),
              ))
          .toList();

      var types2 = (types + subClasses).distinctBy((y) => y.name).toList();

      var extClass = ClassDef(
        element.isAbstract,
        element.name,
        getAllFields(element.allSupertypes, element),
        element.typeParameters.isEmpty //
            ? []
            : element.typeParameters //
                .map((x) => GenericsNameType(x.name, x.bound == null ? null : x.bound.toString()))
                .toList(),
        [
          ...element.interfaces.map((e) => e.element.name),
          element.supertype!.element.name,
        ],
      );

      sb.writeln("// ignore: duplicate_ignore");

      sb.writeln("// ignore_for_file: UNNECESSARY_CAST");
//      sb.writeln("/*" + extClass.fields.toString() + "*/");

      sb.writeln(createCopyWith(extClass, types2));
    }

//    var output = "/*" + sb.toString() + "*/";
    var output = sb.toString();
    return output;
  }
}
