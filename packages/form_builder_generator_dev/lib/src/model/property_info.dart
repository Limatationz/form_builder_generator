import 'element_info.dart';

class PropertyInfo extends ElementInfo {
  final bool isSetter;
  final bool isGetter;

  PropertyInfo({
    required String name,
    required String originalName,
    required bool isPrivate,
    required bool isNullable,
    required this.isSetter,
    required this.isGetter,
  })  : assert(isGetter ^ isSetter),
        super(
            name: name,
            originalName: originalName,
            isPrivate: isPrivate,
            isNullable: isNullable);

  factory PropertyInfo.fromElementInfo(ElementInfo based,
      {required bool isGetter, required bool isSetter}) {
    return PropertyInfo(
        name: based.name,
        originalName: based.originalName,
        isPrivate: based.isPrivate,
        isGetter: isGetter,
        isSetter: isSetter,
        isNullable: based.isNullable);
  }

  String get propertyPrefix => isSetter ? 'Set' : 'Get';
}
