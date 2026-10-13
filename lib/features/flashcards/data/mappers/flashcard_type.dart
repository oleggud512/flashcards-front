import 'package:flashcards/features/flashcards/domain/entities/flashcard_type.dart';

const _contextual = 'contextual';
const _lexical = 'lexical';

extension type const FlashcardTypeStr(String str) {
  FlashcardType? toDomain() => switch (str.toLowerCase()) {
    _lexical => .lexical,
    _contextual => .contextual,
    _ => null,
  };
}

extension FlashcardTypeMapper on FlashcardType {
  String toData() => switch (this) {
    .contextual => _contextual,
    .lexical => _lexical,
  };
}
