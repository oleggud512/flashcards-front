import 'package:flashcards/core/navigation/app_route.dart';

abstract class AppRoutes {
  static const generation = AppRoute(null, name: 'generation', segment: '/');

  static final createRequest = AppRoute(
    generation,
    name: 'create-request',
    segment: 'create-request',
  );

  static final selectActiveBatch = AppRoute(
    createRequest,
    name: 'select-active-batch',
    segment: 'batch',
  );
}
