/// Library
library form_builder_generator_annotation;

import 'package:json_annotation/json_annotation.dart';

/// Annotation for generate names for code entities
/// Tag class or mixin with this annotation
class FormBuilderGeneratorAnnotation {
  /// This setting response for including and excluding elements of class
  final Coverage? coverage;

  const FormBuilderGeneratorAnnotation({this.coverage});
}

///  Annotation for ignore inner elements of class (or mixin)
class FbGenIgnore {
  const FbGenIgnore();
}

///  Annotation for tagging inner elements of class (or mixin)
class FbGenKey {
  /// Set this for override name of element
  final String? name;

  const FbGenKey({this.name});
}

class FbGenOptions {
  /// nullable
  final bool nullable;

  /// ignore
  final bool ignore;

  /// validators
  final String? Function(dynamic)? validators;

  const FbGenOptions(
      {this.nullable = false, this.ignore = false, this.validators});
}

/// Default instance of [Nameof] annotation
const fbGen = FormBuilderGeneratorAnnotation();

/// Default instance of [NameofKey] annotation
const fbGenKey = FbGenKey();

/// Default instance of [NameofIgnore] annotation
const fbGenIgnore = FbGenIgnore();

/// Rule for including inner elements
enum FbGenScope {
  /// Include only public members (fields, methods, etc..)
  onlyPublic,

  /// Include public and private elements
  all
}

/// Behaviour for generating nameof code
enum Coverage {
  /// Include all elements, even not marked with annotation [NameofKey]
  includeImplicit,

  /// Include elements only tagged with annotation [NameofKey]
  excludeImplicit
}

abstract class FormGeneratorValid {
  List<String> getFieldNames();

  List<String> getRequiredFieldNames();
}

abstract class FormGeneratorModel<T> extends JsonSerializable {
  T fromJson(Map<String, dynamic> json);
}
