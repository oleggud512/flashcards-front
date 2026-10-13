import 'package:flashcards/core/client/my_client.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/features/flashcards/domain/entities/created_flashcards_set.dart';
import 'package:flashcards/features/flashcards/domain/entities/generated_speech.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/create_flashcards_set_use_case.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/generate_speech_use_case.dart';
import 'package:flashcards/features/flashcards/failures/generate_speech.dart';

abstract interface class FlashcardsRepository {
  Future<Result<MyClientError, CreatedFlashcardsSet>> createFlashcardsSet(
    CreateFlashcardsSetParams params,
  );

  Future<Result<GenerateSpeechFailure, GeneratedSpeech>> generateSpeech(
    GenerateSpeechParams params,
  );
}
