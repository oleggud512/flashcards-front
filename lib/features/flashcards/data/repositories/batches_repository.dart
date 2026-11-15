import 'dart:async';

import 'package:flashcards/core/database/database_error.dart';
import 'package:flashcards/core/errors/action_executor.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/features/flashcards/data/mappers/batch.dart';
import 'package:flashcards/features/flashcards/data/sources/batches_source.dart';
import 'package:flashcards/features/flashcards/domain/entities/batch_entity.dart';
import 'package:flashcards/features/flashcards/domain/repositories/batches_repository.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/batches/update_batch.dart';

class BatchesRepositoryImpl with ActionExecutor implements BatchesRepository {
  final BatchesSource source;

  new(this.source);

  @override
  Future<Result<DatabaseError, BatchEntity>> createBatch(String name) async {
    final batchRes = await source.createBatch(name);
    return switch (batchRes) {
      Success(:final value) => Success(value.toDomain()),
      Failure(:final failure) => Failure(failure),
    };
  }

  @override
  Future<Result<DatabaseError, void>> deleteBatch(int id) =>
      source.deleteBatch(id);

  @override
  Future<Result<DatabaseError, BatchEntity>> updateBatch(
    UpdateBatchParams params,
  ) async {
    final updRes = await source.updateBatch(params);
    return switch (updRes) {
      Success(:final value) => Success(value.toDomain()),
      Failure(:final failure) => Failure(failure),
    };
  }

  @override
  Stream<Result<DatabaseError, List<BatchEntity>>> watchActiveBatches() =>
      source.watchActiveBatches().map(
        (res) => switch (res) {
          Success(:final value) => Success(
            value.map((batch) => batch.toDomain()).toList(),
          ),
          Failure(:final failure) => Failure(failure),
        },
      );
}
