import 'package:flashcards/features/flashcards/data/repositories/batches_repository_provider.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/batches/watch_active_batches.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'watch_active_batches_provider.g.dart';

@riverpod
WatchActiveBatchesUseCase watchActiveBatchesUseCase(Ref ref) {
  final repo = ref.watch(batchesRepositoryProvider);
  return WatchActiveBatchesUseCase(repo);
}
