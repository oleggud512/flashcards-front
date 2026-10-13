import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated_speech.freezed.dart';

@freezed
sealed class GeneratedSpeech with _$GeneratedSpeech {
  const factory GeneratedSpeech({required List<String> urls}) =
      _GeneratedSpeech;

  const GeneratedSpeech._();
}
