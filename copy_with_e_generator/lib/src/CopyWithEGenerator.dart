import 'dart:async';

import 'package:adi_helpers/stringE.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:copy_with_e_annotation/CopyWithE.dart';
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

        if (el is! ClassElement) //
          throw Exception("the list of types for the copywith def must all be classes");

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

      if (element.typeParameters.length == 0) {
        var extClass = ClassDef(
          element.isAbstract,
          element.name,
          getAllFields(element.allSupertypes, element),
          [],
        );

        sb.writeln("//no generics");

        sb.writeln(createCopyWith(extClass, types2));
      } else {
        var extClass = ClassDef(
          element.isAbstract,
          element.name,
          getAllFields(element.allSupertypes, element),
          element.typeParameters.where((x) => x.name != null).map((x) => //
              GenericType(x.name, x.bound == null ? null : x.bound.toString())).toList(),
        );

        //why is it being returned from the generics equals

//        var result = extClass.fields.where((x) {
//          var matchingGeneric = extClass.generics.firstWhere((g) {
////            sb.writeln("//x.type:${x.type}");
////
////            sb.writeln("//  x.type == g.name:${x.type} == ${g.name} == ${x.type == g.name}");
//            return x.type == g.name || x.type.contains("<${g.name}>");
//          }, orElse: () => null);
//
//          sb.writeln("//${x.name} has matchingGeneric:" + (matchingGeneric != null).toString());
//
//          if (matchingGeneric != null) {
//            sb.writeln("//  matchingGeneric.baseType:" + (matchingGeneric.baseType).toString());
//            sb.writeln("//  matchingGeneric.baseType == null:" + (matchingGeneric.baseType == null).toString());
//            sb.writeln("//  matchingGeneric.baseType == null:" + (matchingGeneric.baseType == "null").toString());
//            sb.writeln("//  matchingGeneric.baseType == '':" + (matchingGeneric.baseType == "").toString());
//          }
//
////          sb.writeln("//${x.name}: " + //
//          //matchingGeneric == null - it did not find it above
////              matchingGeneric.baseType +
////              " | " + //
////              (matchingGeneric == null || matchingGeneric.baseType.isNullOrEmpty()).toString());
//
//          if (matchingGeneric == null || matchingGeneric.baseType.isNullOrEmpty()) //
//            return true;
//
//          return false;
//        }).toList();

//        sb.writeln("//" + result.length.toString());
//
//        sb.writeln("//" + extClass.generics.map((x) => "${x.name} | ${x.baseType}").toList().toString());
//        sb.writeln("//" + extClass.isAbstract.toString());
//        sb.writeln("//" + extClass.name.toString());
//        sb.writeln("//" + extClass.fields.map((x) => "${x.name} | ${x.type}").toList().toString());
//        sb.writeln("//" + types2.map((x) => "${x.name} ${x.}"))

        sb.writeln(createCopyWith(extClass, types2));
      }
    }

    return element.session.getResolvedLibraryByElement(element.library).then((resolvedLibrary) {
      return sb.toString();
    });
  }
}

//GenericType getMatchingGeneric(NameType field, List<GenericType> generics){
//  return generics.firstWhere((g) {
//    return field.type == g.name || field.type.contains("<${g.name}>");
//  }
//}
