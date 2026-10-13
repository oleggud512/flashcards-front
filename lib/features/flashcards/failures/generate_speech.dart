import 'package:flashcards/core/client/my_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_speech.freezed.dart';

@freezed
sealed class GenerateSpeechFailure with _$GenerateSpeechFailure {
  const factory GenerateSpeechFailure.myClient(MyClientError failure) =
      _MyClient;

  const factory GenerateSpeechFailure.invalidResponse() = _InvalidResponse;

  const GenerateSpeechFailure._();
}
