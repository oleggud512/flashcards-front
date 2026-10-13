import 'package:flashcards/core/client/my_client.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/core/interfaces/use_case.dart';
import 'package:flashcards/features/flashcards/domain/entities/created_flashcards_set.dart';
import 'package:flashcards/features/flashcards/domain/repositories/flashcards_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_flashcards_set_use_case.freezed.dart';

class CreateFlashcardsSetUseCase
    implements
        UseCase<
          Future<Result<MyClientError, CreatedFlashcardsSet>>,
          CreateFlashcardsSetParams
        > {
  final FlashcardsRepository _repo;

  new(this._repo);

  @override
  Future<Result<MyClientError, CreatedFlashcardsSet>> call(
    CreateFlashcardsSetParams params,
  ) {
    return _repo.createFlashcardsSet(params);
  }
}

@freezed
sealed class CreateFlashcardsSetParams with _$CreateFlashcardsSetParams {
  const factory CreateFlashcardsSetParams({
    required String word,
    String? additionalParams,
  }) = _CreateFlashcardsSetParams;

  const CreateFlashcardsSetParams._();
}
