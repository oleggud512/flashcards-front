import 'package:flashcards/features/flashcards/data/repositories/batches_repository.dart';
import 'package:flashcards/features/flashcards/data/sources/batches_source_provider.dart';
import 'package:flashcards/features/flashcards/domain/repositories/batches_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'batches_repository_provider.g.dart';

@riverpod
BatchesRepository batchesRepository(Ref ref) {
  final source = ref.watch(batchesSourceProvider);
  return BatchesRepositoryImpl(source);
}
