import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<E, V> with _$Result<E, V> {
  const factory Result.success(V value) = Success;
  const factory Result.failure(E failure) = Failure;

  const Result._();

  V? get valueOrNull => whenOrNull(success: (value) => value);
}
