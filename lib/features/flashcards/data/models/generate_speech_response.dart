import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_speech_response.freezed.dart';
part 'generate_speech_response.g.dart';

@freezed
sealed class GenerateSpeechResponse with _$GenerateSpeechResponse {
  const factory GenerateSpeechResponse({
    @Default(GenerateSpeechData()) GenerateSpeechData data,
  }) = _GenerateSpeechResponse;

  const GenerateSpeechResponse._();

  factory GenerateSpeechResponse.fromJson(Map<String, dynamic> json) =>
      _$GenerateSpeechResponseFromJson(json);
}

@freezed
sealed class GenerateSpeechData with _$GenerateSpeechData {
  const factory GenerateSpeechData({@Default([]) List<String> urls}) =
      _GenerateSpeechData;

  const GenerateSpeechData._();

  factory GenerateSpeechData.fromJson(Map<String, dynamic> json) =>
      _$GenerateSpeechDataFromJson(json);
}
