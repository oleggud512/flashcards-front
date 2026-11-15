import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flashcards/core/database/database.dart';
import 'package:flashcards/core/database/database_error.dart';
import 'package:flashcards/core/errors/action_executor.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/core/utils/logger.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/batches/update_batch.dart';

abstract interface class BatchesSource {
  Stream<Result<DatabaseError, List<BatchDbModel>>> watchActiveBatches();
  Future<Result<DatabaseError, BatchDbModel>> createBatch(String name);
  Future<Result<DatabaseError, void>> deleteBatch(int id);
  Future<Result<DatabaseError, BatchDbModel>> updateBatch(
    UpdateBatchParams params,
  );
}

class BatchesSourceImpl with ActionExecutor implements BatchesSource {
  final AppDatabase db;

  new(this.db);

  @override
  Future<Result<DatabaseError, BatchDbModel>> createBatch(String name) =>
      execute(() async {
        final batch = await db
            .into(db.batchTable)
            .insertReturning(BatchTableCompanion.insert(name: name));
        return Success(batch);
      }, createDefault: (error) => Failure(DatabaseError()));

  @override
  Future<Result<DatabaseError, void>> deleteBatch(int id) => execute(() async {
    final del = db.delete(db.batchTable)..where((tbl) => tbl.id.equals(id));
    final rowsAffected = await del.go();

    if (rowsAffected == 0) {
      glog.e(
        'A batch with an id $id not found',
        stackTrace: StackTrace.current,
      );
      return Failure(DatabaseError());
    }

    return Success(null);
  }, createDefault: (error) => Failure(DatabaseError()));

  @override
  Future<Result<DatabaseError, BatchDbModel>> updateBatch(
    UpdateBatchParams params,
  ) => execute(() async {
    final upd = db.update(db.batchTable)
      ..where((tbl) => tbl.id.equals(params.id));
    final res = await upd.writeReturning(
      BatchTableCompanion(name: Value(params.name)),
    );

    if (res.isEmpty) {
      glog.e(
        'A batch with an id ${params.id} not found',
        stackTrace: StackTrace.current,
      );
      return Failure(DatabaseError());
    }

    return Success(res.first);
  }, createDefault: (error) => Failure(DatabaseError()));

  @override
  Stream<Result<DatabaseError, List<BatchDbModel>>> watchActiveBatches() {
    final query = db.select(db.batchTable)
      ..where((tbl) => tbl.isArchived.equals(false));
    return query.watch().transform(
      StreamTransformer.fromHandlers(
        handleData: (v, sink) => sink.add(Success(v)),
        handleError: (err, st, sink) {
          glog.e(err, stackTrace: st);
          return sink.add(Failure(DatabaseError()));
        },
      ),
    );
  }
}
