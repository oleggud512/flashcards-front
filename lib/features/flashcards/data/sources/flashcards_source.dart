import 'package:flashcards/core/client/flashcards_api.dart';
import 'package:flashcards/core/client/my_client.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/features/flashcards/data/models/flashcards_response.dart';
import 'package:flashcards/features/flashcards/data/models/generate_speech_response.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/create_flashcards_set_use_case.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/generate_speech_use_case.dart';
import 'package:flashcards/features/flashcards/failures/generate_speech.dart';

abstract interface class FlashcardsSource {
  Future<Result<MyClientError, FlashcardsResponse>> createFlashcardsSet(
    CreateFlashcardsSetParams params,
  );

  Future<Result<GenerateSpeechFailure, GenerateSpeechResponse>> generateSpeech(
    GenerateSpeechParams params,
  );
}

class FlashcardsSourceImpl implements FlashcardsSource {
  final MyClient client;

  new(this.client);

  @override
  Future<Result<MyClientError, FlashcardsResponse>> createFlashcardsSet(
    CreateFlashcardsSetParams params,
  ) async {
    final response = await client.request(
      method: .post,
      url: FlashcardsApi.createFlashcardsSet,
      fromJson: (data) => FlashcardsResponse.fromJson(data),
    );

    return response;
  }

  @override
  Future<Result<GenerateSpeechFailure, GenerateSpeechResponse>> generateSpeech(
    GenerateSpeechParams params,
  ) async {
    final response = await client.request(
      method: .post,
      url: FlashcardsApi.generateSpeech,
      fromJson: (data) => GenerateSpeechResponse.fromJson(data),
    );

    switch (response) {
      case Success(:final value):
        if (value.data.urls.length != params.texts.length) {
          return Failure(.invalidResponse());
        }
        return Success(value);
      case Failure(:final failure):
        return Failure(.myClient(failure));
    }
  }
}
