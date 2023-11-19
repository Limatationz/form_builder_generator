// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// FormBuilderGenerator
// **************************************************************************

/// Container for names of elements belonging to the [Person] class
class FbGenClassPerson implements FormGeneratorValid {
  static const String className = 'Person';

  static const String constructor = '';

  static const String fieldFirstName = 'firstName';
  static const String fieldLastName = 'lastName';
  static const String fieldAge = 'age';
  static const String fieldPrice = 'price';
  static const String fieldIsTrue = 'isTrue';
  static const String fieldDate = 'date';
  static const String fieldNullable = 'nullable';
  static const String fieldIgnored = 'ignored';

  static const String functionToJson = 'toJson';
  static const String functionFromJson = 'fromJson';

  @override
  List<String> getFieldNames() => [
        'firstName',
        'lastName',
        'age',
        'price',
        'isTrue',
        'date',
        'nullable',
        'ignored',
      ];

  @override
  List<String> getRequiredFieldNames() => [
        'firstName',
        'lastName',
        'age',
        'price',
        'isTrue',
        'date',
        'ignored',
      ];
}

/// Generates a form builder widget for [Person] class
class PersonFormGenerator extends FormGenerator<Person, FbGenClassPerson> {
  PersonFormGenerator({
    super.key,
    required super.initialValue,
    required super.onSaved,
    super.onError,
    super.decoration,
    super.paddingBetweenFields,
    super.validators,
  }) : super(
          valueType: FbGenClassPerson(),
        );
}
