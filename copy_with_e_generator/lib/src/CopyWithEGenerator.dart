import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:copy_with_e_annotation/CopyWithE.dart';
import 'package:copy_with_e_generator/src/classes.dart';
import 'package:copy_with_e_generator/src/createCopyWith.dart';
import 'package:source_gen/source_gen.dart';

//class ValueTGenerator extends GeneratorForAnnotation<ValueT> {

class CopyWithEGenerator extends GeneratorForAnnotation<CopyWithE> {
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    var sb = StringBuffer();

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
        var fields = ce.fields.map((f) => NameType(f.name, f.type.toString())).toList();
        return ClassDef(ce.isAbstract, ce.name, fields);
      }).toList();
    }

    if (element is ClassElement) {
      var extClass = ClassDef(
        element.isAbstract,
        element.name,
        element.fields.map((x) => NameType(x.name, x.type.toString())).toList(),
      );

      sb.writeln(createCopyWith(extClass, types));
    }

    //extension [getClassName + "ext"] on [getClassName] {
    //  [getClassName] copyWithE(){
    //    //if(getAnnotationTypes() == null){
    //    //  HasAge copyWith(int age) => Person(age, this.name);
    //  }
    //}

//    String pre = null;
//    if (!annotation.read('pre').isNull)
//      pre = annotation.read('pre').stringValue;

//    List<String> exNames = null;
//    if (!annotation.read('exNames').isNull) {
//      exNames = annotation
//          .read('exNames')
//          .listValue
//          .map((x) => x.toStringValue())
//          .toList();

    return element.session.getResolvedLibraryByElement(element.library).then((resolvedLibrary) {
      var declaration = resolvedLibrary.getElementDeclaration(element);
      var unit = declaration.resolvedUnit.unit;

//      sb.writeln(createTypeDef(
//        element.displayName,
//        unit.toString(),
//        element.documentationComment,
//        pre: pre,
//        exNames: exNames,
//      ));

      return sb.toString();
    });
  }
}

//Obsolete get data from code gen
// for (var item in childElements) {
//   sb.writeln("//" + item);
// }

// print("childElements retrieved");

// for (var i = 0; i < childElements.length; i++) {
//   sb.writeln("//$i$childElements[i]");
// }

// sb.writeln("//" + element.name);
// sb.writeln("//" + annotation.toString());
// sb.writeln("//" + element.toString());
// sb.writeln("//" + element.source.fullName);
// sb.writeln("//" + element.displayName);
// sb.writeln("//" + element.name);
// sb.writeln("//" + element.context.runtimeType.toString());
// sb.writeln("//6" + element.context.toString());
// sb.writeln("//7" + element.library.toString());
// sb.writeln("//8" + element.librarySource.toString());
// sb.writeln("//9" + element.source.toString());
// sb.writeln("//10" + element.unit.toSource());

//functionName = get name of function
//element.unit.childEntities.where(
//  substring 0,8 == @TypeddefForFn &&
//  split("/s")[3] == functionName)
//startFnIndx = firstCurlybrace || first =>
//substring(8, startFnIdx)

// sb.writeln("//" + element.unit.toString());
// sb.writeln("//" + element.unit.childEntities.skip(2).first.toString());

// for (var entity in element.unit.childEntities) {
//   sb.writeln("//" + entity.toString());
// }

// sb.writeln("//" + element.unit.beginToken.toString());

// sb.writeln("//" + element.kind.toString());
// sb.writeln("//" + element.name.toString());

// var childElements = element.unit.childEntities.map((x) {
//   // sb.writeln("//" + x.toString());
//   return x.toString();
// }).toList();
