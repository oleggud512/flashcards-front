import 'package:flashcards/core/database/database_error.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/core/interfaces/use_case.dart';
import 'package:flashcards/features/flashcards/domain/entities/batch_entity.dart';
import 'package:flashcards/features/flashcards/domain/repositories/batches_repository.dart';

class CreateBatchUseCase
    implements UseCase<Future<Result<DatabaseError, BatchEntity>>, String> {
  final BatchesRepository repo;

  new(this.repo);

  @override
  Future<Result<DatabaseError, BatchEntity>> call(params) =>
      repo.createBatch(params);
}
