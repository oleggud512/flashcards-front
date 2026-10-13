import 'package:flashcards/core/client/flashcards_api.dart';
import 'package:flashcards/core/client/my_client.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/features/flashcards/data/models/flashcards_response.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/create_flashcards_set_use_case.dart';

abstract interface class FlashcardsSource {
  Future<Result<MyClientError, FlashcardsResponse>> createFlashcardsSet(
    CreateFlashcardsSetParams params,
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
}
