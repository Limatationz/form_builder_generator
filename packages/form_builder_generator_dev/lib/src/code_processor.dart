import 'package:form_builder_generator_annotation/form_builder_generator_annotation.dart';

import 'model/element_info.dart';
import 'model/options.dart';
import 'model/property_info.dart';
import 'util/string_extensions.dart';
import 'visitor.dart';

/// Code lines builder
class FBGenProcessor {
  /// Build options
  final NameofOptions options;

  /// Code info
  final FBGenVisitor visitor;

  FBGenProcessor(this.options, this.visitor);

  String process() {
    return "${_generateNames(visitor)}\n\n${_generateBuilderClass(visitor)}";
  }

  String _generateNames(FBGenVisitor visitor) {
    StringBuffer buffer = StringBuffer();

    final classContainerName = 'FbGenClass${visitor.className}';

    buffer.writeln(
        '/// Container for names of elements belonging to the [${visitor.className}] class');
    buffer.writeln('class $classContainerName implements FormGeneratorValid {');

    final className =
        'static const String className = \'${visitor.className}\';';

    final constructorNames =
        _getCodeParts('constructor', visitor.constructors.values);

    final fieldNames = _getCodeParts('field', visitor.fields.values);

    final functionNames = _getCodeParts('function', visitor.functions.values);

    final propertyNames = _getFilteredNames(visitor.properties.values).map((prop) =>
        'static const String property${(prop as PropertyInfo).propertyPrefix}${prop.originalName.capitalize().privatize()} = \'${prop.name}\';');

    void writeCode(Iterable<String> codeLines) {
      if (codeLines.isNotEmpty) {
        buffer.writeln();
        buffer.writeln(join(codeLines));
      }
    }

    buffer.writeln(className);

    for (var codeLines in [
      constructorNames,
      fieldNames,
      propertyNames,
      functionNames
    ]) {
      writeCode(codeLines);
    }

    // write a list of all field names
    buffer.writeln();
    buffer.writeln('@override');
    buffer.writeln('List<String> getFieldNames() => [');
    buffer.writeln(join(visitor.fields.values.map((e) => '\'${e.name}\',')));
    buffer.writeln('];');

    // write a list of all required field names
    buffer.writeln();
    buffer.writeln('@override');
    buffer.writeln('List<String> getRequiredFieldNames() => [');
    buffer.writeln(join(visitor.fields.values
        .where((e) => !e.isNullable)
        .map((e) => '\'${e.name}\',')));
    buffer.writeln('];');

    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateBuilderClass(FBGenVisitor visitor) {
    StringBuffer buffer = StringBuffer();

    final classContainerName = '${visitor.className}FormGenerator';

    buffer.writeln(
        '/// Generates a form builder widget for [${visitor.className}] class');
    buffer.writeln(
        'class $classContainerName extends FormGenerator<${visitor.className}, FbGenClass${visitor.className}> {');

    final constructorStart = '${visitor.className}FormGenerator({';

    final List<String> constructorParameters = [
      "super.key,",
      "required super.initialValue,",
      "required super.onSaved,",
      "super.onError,",
      "super.decoration,",
      "super.paddingBetweenFields,",
      "super.validators,",
    ];

    final constructorEnd = '}) : super (';

    final List<String> superConstructorParameters = [
      "valueType: FbGenClass${visitor.className}(),",
    ];

    final superConstructorEnd = ');';

    buffer.writeln(constructorStart);

    for (var codeLine in constructorParameters) {
      buffer.writeln(codeLine);
    }

    buffer.writeln(constructorEnd);

    for (var codeLine in superConstructorParameters) {
      buffer.writeln(codeLine);
    }

    buffer.writeln(superConstructorEnd);

    buffer.writeln('}');

    return buffer.toString();
  }

  Iterable<ElementInfo> _getFilteredNames(Iterable<ElementInfo> infos) {
    return options.scope == FbGenScope.onlyPublic
        ? infos.where((element) => !element.isPrivate)
        : infos;
  }

  Iterable<String> _getCodeParts(
      String elementType, Iterable<ElementInfo> elements) {
    return _getFilteredNames(elements).map((element) =>
        'static const String $elementType${element.scopePrefix}${element.originalName.capitalize().privatize()} = \'${element.name}\';');
  }
}
