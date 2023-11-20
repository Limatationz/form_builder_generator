/// Support for doing something awesome.
///
/// More dartdocs go here.
library form_builder_generator_dev;

import 'package:build/build.dart';
import 'package:json_serializable/json_serializable.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator.dart';

/// Builds generators for `build_runner` to run
Builder formBuilderGeneratorBuilder(BuilderOptions options) {
  return PartBuilder(
    [FormBuilderGenerator(options.config), JsonSerializableGenerator()],
    '.fb_gen.dart',
    options: options,
  );
}
