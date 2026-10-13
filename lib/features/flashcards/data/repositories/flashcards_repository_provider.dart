import 'package:flashcards/features/flashcards/data/repositories/flashcards_repository.dart';
import 'package:flashcards/features/flashcards/data/sources/flashcards_source_provider.dart';
import 'package:flashcards/features/flashcards/domain/repositories/flashcards_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flashcards_repository_provider.g.dart';

@riverpod
FlashcardsRepository flashcardsRepository(Ref ref) {
  final source = ref.watch(flashcardsSourceProvider);
  return FlashcardsRepositoryImpl(source);
}
