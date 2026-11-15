import 'package:flashcards/core/database/database_error.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/core/interfaces/use_case.dart';
import 'package:flashcards/features/flashcards/domain/entities/batch_entity.dart';
import 'package:flashcards/features/flashcards/domain/repositories/batches_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_batch.freezed.dart';

class UpdateBatchUseCase
    implements
        UseCase<Future<Result<DatabaseError, BatchEntity>>, UpdateBatchParams> {
  final BatchesRepository repo;

  new(this.repo);

  @override
  Future<Result<DatabaseError, BatchEntity>> call(UpdateBatchParams params) =>
      repo.updateBatch(params);
}

@freezed
sealed class UpdateBatchParams with _$UpdateBatchParams {
  const factory UpdateBatchParams({required int id, required String name}) =
      _UpdateBatchParams;

  const UpdateBatchParams._();
}
