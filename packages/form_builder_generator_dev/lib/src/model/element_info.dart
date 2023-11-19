class ElementInfo {
  final String name;
  final String originalName;
  final bool isPrivate;
  final bool isNullable;

  ElementInfo(
      {required this.name,
      required this.originalName,
      required this.isPrivate,
      this.isNullable = false});

  String get scopePrefix => isPrivate ? 'Private' : '';
}
