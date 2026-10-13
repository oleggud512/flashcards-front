import 'package:flashcards/features/flashcards/data/repositories/flashcards_repository_provider.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/create_flashcards_set_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_flashcards_set_use_case_provider.g.dart';

@riverpod
CreateFlashcardsSetUseCase createFlashcardsSetUseCase(Ref ref) {
  final repo = ref.watch(flashcardsRepositoryProvider);
  return CreateFlashcardsSetUseCase(repo);
}
