import 'package:flashcards/features/flashcards/data/mappers/flashcard_type.dart';
import 'package:flashcards/features/flashcards/data/mappers/german_category_alias.dart';
import 'package:flashcards/features/flashcards/data/models/flashcard_model.dart';
import 'package:flashcards/features/flashcards/domain/entities/flashcard.dart';

extension FlashcardMapper on FlashcardModel {
  Flashcard toDomain() => Flashcard(
    category: category != null
        ? GermanCategoryAliasStr(category!).toDomain()
        : null,
    type: type != null ? FlashcardTypeStr(type!).toDomain() : null,

    front: front ?? '',
    frontHint: frontHint ?? '',
    back: back ?? '',
    meaning: meaning ?? '',
    grammar: grammar ?? '',
    example: example ?? '',

    audio: audio ?? '',
  );
}
