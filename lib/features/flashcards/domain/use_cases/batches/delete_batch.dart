import 'package:flashcards/core/database/database_error.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/core/interfaces/use_case.dart';
import 'package:flashcards/features/flashcards/domain/repositories/batches_repository.dart';

class DeleteBatchUseCase
    implements UseCase<Future<Result<DatabaseError, void>>, int> {
  final BatchesRepository repo;

  new(this.repo);

  @override
  Future<Result<DatabaseError, void>> call(int id) => repo.deleteBatch(id);
}
