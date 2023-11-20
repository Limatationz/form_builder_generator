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

  static Person fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
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
          fromJson: FbGenClassPerson.fromJson,
        );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as int,
      price: (json['price'] as num).toDouble(),
      isTrue: json['isTrue'] as bool,
      date: DateTime.parse(json['date'] as String),
      nullable: json['nullable'] as int?,
      ignored: json['ignored'] as int?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'age': instance.age,
      'price': instance.price,
      'isTrue': instance.isTrue,
      'date': instance.date.toIso8601String(),
      'nullable': instance.nullable,
      'ignored': instance.ignored,
    };
