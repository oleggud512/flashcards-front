sealed class Result<E, V> {
  V? get valueOrNull => switch (this) {
    Success(:final value) => value,
    Failure() => null,
  };
}

class Success<E, V> extends Result<E, V> {
  final V value;
  Success(this.value);

  @override
  String toString() => "$runtimeType($value)";
}

class Failure<E, V> extends Result<E, V> {
  final E failure;
  Failure(this.failure);

  @override
  String toString() => "$runtimeType($failure)";
}
