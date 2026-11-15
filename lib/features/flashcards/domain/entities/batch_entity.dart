import 'package:freezed_annotation/freezed_annotation.dart';

part 'batch_entity.freezed.dart';

@freezed
sealed class BatchEntity with _$BatchEntity {
  const factory BatchEntity({
    required int id,
    required bool isArchived,
    required String name,
    required DateTime createdAt,
  }) = _BatchEntity;

  const BatchEntity._();
}
