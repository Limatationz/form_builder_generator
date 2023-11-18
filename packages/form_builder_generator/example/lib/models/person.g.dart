// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as int,
    )
      ..price = (json['price'] as num).toDouble()
      ..isTrue = json['isTrue'] as bool
      ..date = DateTime.parse(json['date'] as String);

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'age': instance.age,
      'price': instance.price,
      'isTrue': instance.isTrue,
      'date': instance.date.toIso8601String(),
    };
