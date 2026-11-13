import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_batch.freezed.dart';

@freezed
sealed class UpdateBatchParams with _$UpdateBatchParams {
  const factory UpdateBatchParams({required int id, required String name}) =
      _UpdateBatchParams;

  const UpdateBatchParams._();
}
