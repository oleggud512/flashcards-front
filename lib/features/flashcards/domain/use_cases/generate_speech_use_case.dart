import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/features/flashcards/domain/entities/generated_speech.dart';
import 'package:flashcards/features/flashcards/domain/repositories/flashcards_repository.dart';
import 'package:flashcards/features/flashcards/failures/generate_speech.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flashcards/core/interfaces/use_case.dart';

part 'generate_speech_use_case.freezed.dart';

class GenerateSpeechUseCase
    implements
        UseCase<
          Future<Result<GenerateSpeechFailure, GeneratedSpeech>>,
          GenerateSpeechParams
        > {
  final FlashcardsRepository _repo;

  new(this._repo);

  @override
  Future<Result<GenerateSpeechFailure, GeneratedSpeech>> call(
    GenerateSpeechParams params,
  ) {
    return _repo.generateSpeech(params);
  }
}

@freezed
sealed class GenerateSpeechParams with _$GenerateSpeechParams {
  const factory GenerateSpeechParams({required List<String> texts}) =
      _GenerateSpeechParams;

  const GenerateSpeechParams._();
}
