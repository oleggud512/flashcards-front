import 'package:flashcards/core/navigation/app_routes.dart';
import 'package:flashcards/features/flashcards/presentation/screens/generations_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.generation,
    routes: [
      GoRoute(
        path: AppRoutes.generation,
        builder: (context, state) => GenerationsScreen(),
      ),
    ],
  );
}
