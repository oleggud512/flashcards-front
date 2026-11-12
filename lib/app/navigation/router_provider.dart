import 'package:flashcards/core/navigation/app_routes.dart';
import 'package:flashcards/features/flashcards/presentation/screens/create_request_screen.dart';
import 'package:flashcards/features/flashcards/presentation/screens/generations_screen.dart';
import 'package:flashcards/features/flashcards/presentation/screens/select_active_batch_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.generation.fullPath,
    routes: [
      GoRoute(
        name: AppRoutes.generation.name,
        path: AppRoutes.generation.segment,
        builder: (context, state) => GenerationsScreen(),
        routes: [
          GoRoute(
            name: AppRoutes.createRequest.name,
            path: AppRoutes.createRequest.segment,
            builder: (context, state) => CreateRequestScreen(),
            routes: [
              GoRoute(
                name: AppRoutes.selectActiveBatch.name,
                path: AppRoutes.selectActiveBatch.segment,
                builder: (context, state) => SelectActiveBatchScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
