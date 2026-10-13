import 'package:flashcards/core/client/my_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_client_provider.g.dart';

@riverpod
MyClient myClient(Ref ref) {
  final client = MyClient(baseUrl: 'http://localhost:8081');
  ref.onDispose(client.close);
  return client;
}
