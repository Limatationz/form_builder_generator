import 'package:form_builder_generator_annotation/form_builder_generator_annotation.dart';

/// Generator options
class NameofOptions {
  /// Exclude and include rules
  final Coverage coverage;

  /// Scope options (public or all)
  final FbGenScope scope;

  NameofOptions({required this.coverage, required this.scope});
}
