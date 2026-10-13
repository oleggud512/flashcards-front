import 'package:flashcards/core/client/my_client_provider.dart';
import 'package:flashcards/features/flashcards/data/sources/flashcards_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flashcards_source_provider.g.dart';

@riverpod
FlashcardsSource flashcardsSource(Ref ref) {
  final client = ref.watch(myClientProvider);
  return FlashcardsSourceImpl(client);
}
