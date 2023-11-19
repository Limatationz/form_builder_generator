import 'package:form_builder_generator/form_builder_generator.dart';
import 'package:form_builder_generator_annotation/form_builder_generator_annotation.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.fb_gen.dart';

part 'person.g.dart';

@fbGen
@JsonSerializable()
class Person extends FormGeneratorModel<Person> {
  String firstName;
  String lastName;
  int age;
  double price = 0.0;
  bool isTrue = true;
  DateTime date = DateTime.now();
  @FbGenOptions(nullable: true)
  int? nullable;
  @FbGenOptions(ignore: true)
  int? ignored;

  Person(
      {required this.firstName,
      required this.lastName,
      required this.age,
      this.nullable,
      this.ignored});

  @override
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  Person fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
