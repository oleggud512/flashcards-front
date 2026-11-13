import 'package:flashcards/core/database/database_provider.dart';
import 'package:flashcards/features/flashcards/data/sources/batches_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'batches_source_provider.g.dart';

@riverpod
BatchesSource batchesSource(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return BatchesSourceImpl(db);
}
