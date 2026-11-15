import 'package:flashcards/features/flashcards/data/repositories/batches_repository_provider.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/batches/create_batch.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_batch_provider.g.dart';

@riverpod
CreateBatchUseCase createBatchUseCase(Ref ref) {
  final repo = ref.watch(batchesRepositoryProvider);
  return CreateBatchUseCase(repo);
}
