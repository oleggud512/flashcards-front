import 'package:flashcards/core/database/database_error.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/features/flashcards/domain/entities/batch_entity.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/batches/update_batch.dart';

abstract interface class BatchesRepository {
  Stream<Result<DatabaseError, List<BatchEntity>>> watchActiveBatches();
  Future<Result<DatabaseError, BatchEntity>> createBatch(String name);
  Future<Result<DatabaseError, void>> deleteBatch(int id);
  Future<Result<DatabaseError, BatchEntity>> updateBatch(
    UpdateBatchParams params,
  );
}
