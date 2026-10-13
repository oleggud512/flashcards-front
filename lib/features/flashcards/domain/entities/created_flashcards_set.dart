import 'package:freezed_annotation/freezed_annotation.dart';

import 'flashcard.dart';

part 'created_flashcards_set.freezed.dart';

@freezed
sealed class CreatedFlashcardsSet with _$CreatedFlashcardsSet {
  const factory CreatedFlashcardsSet({required List<Flashcard> flashcards}) =
      _CreatedFlashcardsSet;

  const CreatedFlashcardsSet._();
}
