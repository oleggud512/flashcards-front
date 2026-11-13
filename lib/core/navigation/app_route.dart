class AppRoute {
  const new(this.parent, {required this.name, required this.segment});

  final String name;

  final String segment;

  final AppRoute? parent;

  String get fullPath {
    final parent = this.parent;
    if (parent == null) return segment;
    final base = parent.fullPath;
    return base.endsWith('/') ? '$base$segment' : '$base/$segment';
  }

  @override
  String toString() => 'AppRoute($name, $fullPath)';
}

String? _str(String v) => v;
int? _int(String v) => int.tryParse(v);

class AppRouteParam<T> extends AppRoute {
  const new(
    super.parent, {
    required super.name,
    required this.paramName,
    required this.parse,
  }) : super(segment: ':$paramName');

  final String paramName;

  final T? Function(String) parse;

  T? extract(Map<String, String> pathParameters) {
    final v = pathParameters[paramName];
    if (v == null) return null;
    return parse(v);
  }

  @override
  String toString() => 'AppRouteParam($name, $fullPath)';

  static AppRouteParam<String> string(
    AppRoute? parent, {
    required String name,
    required String paramName,
  }) => AppRouteParam(parent, name: name, paramName: paramName, parse: _str);

  static AppRouteParam<int> integer(
    AppRoute? parent, {
    required String name,
    required String paramName,
  }) => AppRouteParam(parent, name: name, paramName: paramName, parse: _int);
}
