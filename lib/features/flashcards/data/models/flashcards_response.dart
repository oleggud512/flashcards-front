import 'package:freezed_annotation/freezed_annotation.dart';

import 'flashcard_model.dart';

part 'flashcards_response.freezed.dart';
part 'flashcards_response.g.dart';

@freezed
sealed class FlashcardsResponse with _$FlashcardsResponse {
  factory FlashcardsResponse({
    @Default(FlashcardsResponseData()) FlashcardsResponseData data,
  }) = _FlashcardsResponse;

  const FlashcardsResponse._();

  factory FlashcardsResponse.fromJson(Map<String, dynamic> json) =>
      _$FlashcardsResponseFromJson(json);
}

@freezed
sealed class FlashcardsResponseData with _$FlashcardsResponseData {
  const factory FlashcardsResponseData({
    @Default([]) List<FlashcardModel> cards,
  }) = _FlashcardsResponseData;

  const FlashcardsResponseData._();

  factory FlashcardsResponseData.fromJson(Map<String, dynamic> json) =>
      _$FlashcardsResponseDataFromJson(json);
}
