import 'package:flashcards/core/utils/logger.dart';

import 'result.dart';

mixin ActionExecutor {
  Future<Result<T, E>> execute<T, E>(
    Future<Result<T, E>> Function() action, {
    required Result<T, E> Function(Object error) createDefault,
    Result<T, E>? Function(
      Object error,
      void Function(String message) logAsSevere,
    )?
    onError,
  }) async {
    final callerTrace = StackTrace.current;

    try {
      return await action();
    } catch (e, st) {
      void logAsSevere(String message) {
        glog.e(
          "$message\n--- Caller Trace ---\n$callerTrace",
          error: e,
          stackTrace: st,
        );
      }

      if (onError != null) {
        final customResult = onError(e, logAsSevere);
        if (customResult != null) {
          return customResult;
        }
      }

      logAsSevere("Action Execution Failure");
      return createDefault(e);
    }
  }
}
