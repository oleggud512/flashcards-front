abstract class AppRoutes {
  static const generation = AppRoute.root('generation', '/');

  static final createRequest = AppRoute(
    generation,
    'create-request',
    'create-request',
  );

  static final selectActiveBatch = AppRoute(
    createRequest,
    'select-active-batch',
    'select-active-batch',
  );
}

class AppRoute {
  const new(this.parent, this.name, this.segment);

  const new root(this.name, this.segment) : parent = null;

  final String name;
  final String segment;
  final AppRoute? parent;

  String? get paramName =>
      segment.startsWith(':') ? segment.substring(1) : null;

  String? extractParam(Map<String, String> pathParameters) {
    final param = paramName;
    return param == null ? null : pathParameters[param];
  }

  String get fullPath {
    final parent = this.parent;
    if (parent == null) return segment;
    final base = parent.fullPath;
    return base.endsWith('/') ? '$base$segment' : '$base/$segment';
  }

  @override
  String toString() => 'AppRoute($name, $fullPath)';
}
