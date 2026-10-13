import 'package:flashcards/core/client/my_client.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/features/flashcards/data/mappers/flashcard.dart';
import 'package:flashcards/features/flashcards/data/sources/flashcards_source.dart';
import 'package:flashcards/features/flashcards/domain/entities/created_flashcards_set.dart';
import 'package:flashcards/features/flashcards/domain/entities/generated_speech.dart';
import 'package:flashcards/features/flashcards/domain/repositories/flashcards_repository.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/create_flashcards_set_use_case.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/generate_speech_use_case.dart';
import 'package:flashcards/features/flashcards/failures/generate_speech.dart';

class FlashcardsRepositoryImpl implements FlashcardsRepository {
  final FlashcardsSource source;

  new(this.source);

  @override
  Future<Result<MyClientError, CreatedFlashcardsSet>> createFlashcardsSet(
    CreateFlashcardsSetParams params,
  ) async {
    final response = await source.createFlashcardsSet(params);

    return switch (response) {
      Success(:final value) => Success(
        CreatedFlashcardsSet(
          flashcards: value.data.cards.map((f) => f.toDomain()).toList(),
        ),
      ),
      Failure(:final failure) => Failure(failure),
    };
  }

  @override
  Future<Result<GenerateSpeechFailure, GeneratedSpeech>> generateSpeech(
    GenerateSpeechParams params,
  ) async {
    final response = await source.generateSpeech(params);

    return switch (response) {
      Success(:final value) => Success(GeneratedSpeech(urls: value.data.urls)),
      Failure(:final failure) => Failure(failure),
    };
  }
}
