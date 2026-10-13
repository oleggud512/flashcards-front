import 'package:freezed_annotation/freezed_annotation.dart';

part 'flashcard_model.freezed.dart';
part 'flashcard_model.g.dart';

@freezed
sealed class FlashcardModel with _$FlashcardModel {
  const factory FlashcardModel({
    String? category,
    String? type,

    String? front,
    String? frontHint,
    String? back,
    String? meaning,
    String? grammar,
    String? example,

    String? audio,
  }) = _FlashcardModel;

  const FlashcardModel._();

  factory FlashcardModel.fromJson(Map<String, dynamic> json) =>
      _$FlashcardModelFromJson(json);
}
