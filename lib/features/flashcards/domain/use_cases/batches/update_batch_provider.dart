import 'package:flashcards/features/flashcards/data/repositories/batches_repository_provider.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/batches/update_batch.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_batch_provider.g.dart';

@riverpod
UpdateBatchUseCase updateBatchUseCase(Ref ref) {
  final repo = ref.watch(batchesRepositoryProvider);
  return UpdateBatchUseCase(repo);
}
