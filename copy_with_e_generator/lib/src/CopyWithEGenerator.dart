import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';
import 'package:copy_with_e_generator/src/classes.dart';
import 'package:copy_with_e_generator/src/createCopyWith.dart';
import 'package:dartx/dartx.dart';
import 'package:source_gen/source_gen.dart';

import 'GeneratorForAnnotationX.dart';

List<NameType> getAllFields(List<InterfaceType> interfaceTypes, ClassElement element) {
  var superTypeFields = interfaceTypes //
      .where((x) => x.element.name != "Object")
      .flatMap((st) => st.element.fields.map((f) => //
          NameType(f.name, f.type.toString())))
      .toList();
  var classFields = element.fields.map((f) => //
      NameType(f.name, f.type.toString())).toList();

  return (classFields + superTypeFields).distinctBy((x) => x.name).toList();
}

class CopyWithEGenerator extends GeneratorForAnnotationX<CopyWithE> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
    List<ClassElement> allClasses,
  ) {
    var sb = StringBuffer();

    sb.writeln("//RULES: 1 all subtypes must be in same file or be passed in. 2 the types passed in must all be classes");

    var types = List<ClassDef>();
    if (!annotation.read('types').isNull) {
      types = annotation
          .read('types') //
          .listValue
          .map((x) {
        var el = x.toTypeValue().element;

        if (el is! ClassElement) {
          throw Exception("the list of types for the copywith def must all be classes");
        }

        var ce = (el as ClassElement);

        return ClassDef(ce.isAbstract, ce.name, getAllFields(ce.allSupertypes, ce), []);
      }).toList();
    }

    if (element is ClassElement) {
      var subClasses = allClasses //
          .where((x) => x.allSupertypes.any((st) => st.element.name == element.name))
          .where((x) => !types.any((t) => t.name == x.name))
          .map((x) => ClassDef(x.isAbstract, x.name, getAllFields(x.allSupertypes, x), []))
          .toList();

      var types2 = (types + subClasses).distinctBy((y) => y.name).toList();

      var extClass = ClassDef(
        element.isAbstract,
        element.name,
        getAllFields(element.allSupertypes, element),
        element.typeParameters.isEmpty ? [] : element.typeParameters.where((x) => x.name != null).map((x) => //
            GenericType(x.name, x.bound == null ? null : x.bound.toString())).toList(),
      );

      sb.writeln(createCopyWith(extClass, types2));
    }

    return element.session.getResolvedLibraryByElement(element.library).then((resolvedLibrary) {
      return sb.toString();
    });
  }
}
