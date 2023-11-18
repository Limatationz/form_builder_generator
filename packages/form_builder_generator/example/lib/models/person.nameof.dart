// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// NameofGenerator
// **************************************************************************

/// Container for names of elements belonging to the [Person] class
class NameofPerson implements FormGeneratorValid {
  static const String className = 'Person';

  static const String constructor = '';

  static const String fieldFirstName = 'firstName';
  static const String fieldLastName = 'lastName';
  static const String fieldAge = 'age';
  static const String fieldPrice = 'price';
  static const String fieldIsTrue = 'isTrue';
  static const String fieldDate = 'date';

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
      ];
}

/// Generates a form builder widget for [Person] class
class PersonFormGenerator extends FormGenerator<Person, NameofPerson> {
  PersonFormGenerator({
    super.key,
    required super.initialValue,
    required super.onSaved,
    super.onError,
    super.decoration,
    super.paddingBetweenFields,
    super.validators,
  }) : super(
          valueType: NameofPerson(),
        );
}
