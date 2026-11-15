import 'package:flashcards/features/flashcards/data/repositories/batches_repository_provider.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/batches/delete_batch.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_batch_provider.g.dart';

@riverpod
DeleteBatchUseCase deleteBatchUseCase(Ref ref) {
  final repo = ref.watch(batchesRepositoryProvider);
  return DeleteBatchUseCase(repo);
}
