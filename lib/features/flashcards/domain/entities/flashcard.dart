import 'package:freezed_annotation/freezed_annotation.dart';

import 'flashcard_type.dart';
import 'german_category_alias.dart';

part 'flashcard.freezed.dart';

@freezed
sealed class Flashcard with _$Flashcard {
  const factory Flashcard({
    required FlashcardType? type,
    required GermanCategoryAlias? category,

    required String front,
    required String frontHint,
    required String back,
    required String meaning,
    required String grammar,
    required String example,

    required String audio,
  }) = _Flashcard;

  const Flashcard._();
}
