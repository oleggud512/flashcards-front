abstract class FlashcardsApi {
  static final base = "/api/v1";

  /// Methods: [POST]
  static final createFlashcardsSet = "$base/flashcards/word";

  /// Methods: [POST]
  static final createAudios = "$base/tts";
}
