library form_builder_generator;

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_generator_annotation/form_builder_generator_annotation.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormGenerator<T, R extends FormGeneratorValid> extends StatefulWidget {
  /// Initial value for form
  final T? initialValue;
  final R valueType;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  /// Callback for when form is saved
  final Function(T) onSaved;

  /// Callback for when form has errors
  final Function(Map<String, String>)? onError;

  /// Decoration for form fields
  final InputDecoration? decoration;

  /// Vertical padding between form fields
  final double? paddingBetweenFields;

  /// Validators for form fields (required validator is added automatically)
  /// Key is field name
  /// Value is list of validators
  /// Example:
  /// ```dart
  ///  'firstName': [
  ///  FormBuilderValidators.minLength(3),
  ///  ],
  ///  ```
  final Map<String, List<String? Function(dynamic)>>? validators;

  /// Builder for submit button
  /// Otherwise an basic elevated button is used
  final Function(BuildContext, VoidCallback)? submitButtonBuilder;

  /// Whether the whole form is enabled or not
  final bool enabled;

  /// Autovalidate mode for form
  final AutovalidateMode? autovalidateMode;

  /// Callback for when form is changed
  final VoidCallback? onChanged;

  FormGenerator(
      {super.key,
      required this.valueType,
      required this.onSaved,
      required this.fromJson,
      required this.toJson,
      this.initialValue,
      this.onError,
      this.decoration,
      this.paddingBetweenFields,
      this.validators,
      this.submitButtonBuilder,
      this.enabled = true,
      this.autovalidateMode,
      this.onChanged})
      : assert(initialValue == null ||
            valueType.runtimeType
                .toString()
                .contains(initialValue.runtimeType.toString()));

  @override
  State<FormGenerator<T, R>> createState() => _FormGeneratorState<T, R>();
}

class _FormGeneratorState<T, R extends FormGeneratorValid>
    extends State<FormGenerator<T, R>> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      onChanged: widget.onChanged,
      key: _formKey,
      child: Column(children: [
        ...widget.valueType.getFieldNames().mapIndexed((index, e) => Padding(
            padding: EdgeInsets.only(bottom: widget.paddingBetweenFields ?? 0),
            child: Builder(builder: (context) {
              final dynamic field = widget.initialValue != null
                  ? widget.toJson(widget.initialValue!)[e]
                  : null;
              final fieldType = field.runtimeType;
              final bool isLast =
                  index == widget.valueType.getFieldNames().length - 1;
              final inputAction =
                  isLast ? TextInputAction.done : TextInputAction.next;
              final inputDecoration =
                  (widget.decoration ?? InputDecoration()).copyWith(
                labelText: e,
              );
              final isRequired =
                  widget.valueType.getRequiredFieldNames().contains(e);

              List<String? Function(dynamic)>? validators;
              if (widget.validators?.containsKey(e) ?? false) {
                validators = widget.validators?[e];
              }

              String? Function(dynamic)? fieldValidators = null;
              if (isRequired || validators != null) {
                fieldValidators = FormBuilderValidators.compose([
                  if (isRequired) FormBuilderValidators.required(),
                  if (validators != null) ...validators,
                ]);
              }

              final date = DateTime.tryParse(field.toString());
              if (date != null) {
                return FormBuilderDateTimePicker(
                  name: e,
                  initialValue: date,
                  decoration: inputDecoration,
                  textInputAction: inputAction,
                  valueTransformer: (value) {
                    return value!.toIso8601String();
                  },
                  validator: fieldValidators,
                );
              } else if (fieldType == String) {
                return FormBuilderTextField(
                  name: e,
                  decoration: inputDecoration,
                  initialValue: field,
                  textInputAction: inputAction,
                  validator: fieldValidators,
                );
              } else if (fieldType == int || fieldType == double) {
                return FormBuilderTextField(
                  name: e,
                  decoration: inputDecoration,
                  keyboardType: TextInputType.number,
                  initialValue: field.toString(),
                  valueTransformer: (value) {
                    if (fieldType == int) {
                      return int.parse(value!);
                    } else if (fieldType == double) {
                      return double.parse(value!);
                    }
                  },
                  textInputAction: inputAction,
                  validator: fieldValidators,
                );
              } else if (fieldType == bool) {
                return FormBuilderCheckbox(
                  name: e,
                  initialValue: field,
                  decoration: inputDecoration,
                  title: Text(e),
                  validator: fieldValidators,
                );
              }

              return FormBuilderTextField(
                name: e,
                decoration: inputDecoration,
                initialValue: field.toString(),
                textInputAction: inputAction,
                validator: fieldValidators,
              );
            }))),
        Builder(builder: (context) {
          onPressed() {
            if (_formKey.currentState!.saveAndValidate()) {
              print(jsonEncode(_formKey.currentState!.value));
              final newPerson = widget.fromJson(_formKey.currentState!.value);
              widget.onSaved(newPerson);
            } else {
              final error = _formKey.currentState!.errors;
              widget.onError?.call(error);
            }
          }

          if (widget.submitButtonBuilder == null) {
            return ElevatedButton(
                onPressed: onPressed, child: const Text('Submit'));
          } else {
            return widget.submitButtonBuilder!(context, onPressed);
          }
        }),
      ]),
    );
  }
}
