import 'package:nameof/src/util/string_extensions.dart';
import 'package:nameof_annotation/nameof_annotation.dart';

import 'model/element_info.dart';
import 'model/options.dart';
import 'model/property_info.dart';
import 'nameof_visitor.dart';

/// Code lines builder
class NameofCodeProcessor {
  /// Build options
  final NameofOptions options;

  /// Code info
  final NameofVisitor visitor;

  NameofCodeProcessor(this.options, this.visitor);

  String process() {
    return "${_generateNames(visitor)}\n\n${_generateBuilderClass(visitor)}";
  }

  String _generateNames(NameofVisitor visitor) {
    StringBuffer buffer = StringBuffer();

    final classContainerName = 'Nameof${visitor.className}';

    buffer.writeln(
        '/// Container for names of elements belonging to the [${visitor.className}] class');
    buffer.writeln('class $classContainerName implements FormGeneratorValid {');

    final className =
        'static const String className = \'${visitor.className}\';';

    final constructorNames =
        _getCodeParts('constructor', visitor.constructors.values);

    final fieldNames = _getCodeParts('field', visitor.fields.values);

    print(visitor.fields.values.map((e) => e.name));

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

    // write a function

    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateBuilderClass(NameofVisitor visitor) {
    StringBuffer buffer = StringBuffer();

    final classContainerName = '${visitor.className}FormGenerator';

    buffer.writeln(
        '/// Generates a form builder widget for [${visitor.className}] class');
    buffer.writeln(
        'class $classContainerName extends FormGenerator<${visitor.className}, Nameof${visitor.className}> {');

    final constructorStart = 'PersonFormGenerator({';

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
      "valueType: Nameof${visitor.className}(),",
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
    Iterable<ElementInfo> result = (options.coverage == Coverage.includeImplicit
            ? infos.map((e) => e)
            : infos.where((element) => element.isAnnotated).map((e) => e))
        .where((element) => !element.isIgnore);

    return options.scope == NameofScope.onlyPublic
        ? result.where((element) => !element.isPrivate)
        : result;
  }

  Iterable<String> _getCodeParts(
      String elementType, Iterable<ElementInfo> elements) {
    return _getFilteredNames(elements).map((element) =>
        'static const String $elementType${element.scopePrefix}${element.originalName.capitalize().privatize()} = \'${element.name}\';');
  }
}
