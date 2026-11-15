import 'package:flashcards/core/database/database_error.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/core/interfaces/use_case.dart';
import 'package:flashcards/features/flashcards/domain/entities/batch_entity.dart';
import 'package:flashcards/features/flashcards/domain/repositories/batches_repository.dart';

class WatchActiveBatchesUseCase
    implements
        UseCase<Stream<Result<DatabaseError, List<BatchEntity>>>, NoParams> {
  final BatchesRepository repo;

  new(this.repo);

  @override
  Stream<Result<DatabaseError, List<BatchEntity>>> call(NoParams params) =>
      repo.watchActiveBatches();
}
