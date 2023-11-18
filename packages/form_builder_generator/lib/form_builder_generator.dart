library form_builder_generator;

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nameof_annotation/nameof_annotation.dart';

class FormGenerator<T extends FormGeneratorModel, R extends FormGeneratorValid>
    extends StatefulWidget {
  final T initialValue;
  final R valueType;

  final Function(T) onSaved;
  final Function(Map<String, String>)? onError;

  final InputDecoration decoration;

  final double? paddingBetweenFields;

  final Map<String, String? Function(dynamic)>? validators;

  final Function(BuildContext, VoidCallback)? submitButtonBuilder;

  const FormGenerator(
      {super.key,
        required this.initialValue,
        required this.valueType,
        required this.onSaved,
        this.onError,
        this.decoration = const InputDecoration(),
        this.paddingBetweenFields,
        this.validators,
        this.submitButtonBuilder});

  @override
  State<FormGenerator<T, R>> createState() => _FormGeneratorState<T, R>();
}

class _FormGeneratorState<T extends FormGeneratorModel,
R extends FormGeneratorValid> extends State<FormGenerator<T, R>> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(children: [
        ...widget.valueType.getFieldNames().mapIndexed((index, e) => Padding(
            padding: EdgeInsets.only(bottom: widget.paddingBetweenFields ?? 0),
            child: Builder(builder: (context) {
              final dynamic field = widget.initialValue.toJson()[e];
              final fieldType = field.runtimeType;
              final bool isLast =
                  index == widget.valueType.getFieldNames().length - 1;
              final inputAction =
              isLast ? TextInputAction.done : TextInputAction.next;
              final inputDecoration = widget.decoration.copyWith(
                labelText: e,
              );

              String? Function(dynamic)? validator;
              if (widget.validators?.containsKey(e) ?? false) {
                validator = widget.validators?[e];
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
                  validator: validator,
                );
              } else if (fieldType == String) {
                return FormBuilderTextField(
                  name: e,
                  decoration: inputDecoration,
                  initialValue: field,
                  textInputAction: inputAction,
                  validator: validator,
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
                  validator: validator,
                );
              } else if (fieldType == bool) {
                return FormBuilderCheckbox(
                  name: e,
                  initialValue: field,
                  decoration: inputDecoration,
                  title: Text(e),
                  validator: validator,
                );
              }

              return FormBuilderTextField(
                name: e,
                decoration: inputDecoration,
                initialValue: field.toString(),
                textInputAction: inputAction,
                validator: validator,
              );
            }))),
        Builder(builder: (context) {
          onPressed() {
            if (_formKey.currentState!.saveAndValidate()) {
              print(jsonEncode(_formKey.currentState!.value));
              final newPerson =
              widget.initialValue.fromJson(_formKey.currentState!.value);
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

