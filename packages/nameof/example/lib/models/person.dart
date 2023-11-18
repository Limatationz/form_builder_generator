import 'package:json_annotation/json_annotation.dart';
import 'package:nameof_annotation/nameof_annotation.dart';

import '../../../../form_builder_generator/lib/form_generator.dart';


part 'person.nameof.dart';

part 'person.g.dart';

@nameof
@JsonSerializable()
class Person extends FormGeneratorModel<Person> {
  String firstName;
  String lastName;
  int age;

  double price = 0.0;

  bool isTrue = true;

  DateTime date = DateTime.now();

  Person({required this.firstName, required this.lastName, required this.age});

  @override
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  Person fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
