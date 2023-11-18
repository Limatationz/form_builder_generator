/// Library
library nameof_annotation;
// export '../../nameof/example/lib/form_generator.dart';

import 'package:json_annotation/json_annotation.dart';

/// Annotation for generate names for code entities
/// Tag class or mixin with this annotation
class Nameof {
  /// This setting response for including and excluding elements of class
  final Coverage? coverage;

  const Nameof({this.coverage});
}

///  Annotation for ignore inner elements of class (or mixin)
class NameofIgnore {
  const NameofIgnore();
}

///  Annotation for tagging inner elements of class (or mixin)
class NameofKey {
  /// Set this for override name of element
  final String? name;

  const NameofKey({this.name});
}

/// Default instanse of [Nameof] annotation
const nameof = Nameof();

/// Default instanse of [NameofKey] annotation
const nameofKey = NameofKey();

/// Default instanse of [NameofIgnore] annotation
const nameofIgnore = NameofIgnore();

/// Rule for including inner elements
enum NameofScope {
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
}

abstract class FormGeneratorModel<T> extends JsonSerializable {
  T fromJson(Map<String, dynamic> json);
}