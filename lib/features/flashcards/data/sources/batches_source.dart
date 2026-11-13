import 'package:drift/drift.dart';
import 'package:flashcards/core/database/database.dart';
import 'package:flashcards/core/errors/action_executor.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/batches/update_batch.dart';

abstract interface class BatchesSource {
  Stream<List<BatchDbModel>> watchActiveBatches();
  Future<BatchDbModel> createBatch(String name);
  Future<void> deleteBatch(int id);
  Future<BatchDbModel?> updateBatch(UpdateBatchParams params);
}

class BatchesSourceImpl with ActionExecutor implements BatchesSource {
  final AppDatabase db;

  new(this.db);

  @override
  Future<BatchDbModel> createBatch(String name) async {
    final batch = await db
        .into(db.batchTable)
        .insertReturning(BatchTableCompanion.insert(name: name));
    return batch;
  }

  @override
  Future<void> deleteBatch(int id) async {
    final del = db.delete(db.batchTable)..where((tbl) => tbl.id.equals(id));
    await del.go();
  }

  @override
  Future<BatchDbModel?> updateBatch(UpdateBatchParams params) async {
    final upd = db.update(db.batchTable)
      ..where((tbl) => tbl.id.equals(params.id));
    final res = await upd.writeReturning(
      BatchTableCompanion(name: Value(params.name)),
    );
    return res.firstOrNull;
  }

  @override
  Stream<List<BatchDbModel>> watchActiveBatches() {
    final query = db.select(db.batchTable)
      ..where((tbl) => tbl.isArchived.equals(false));
    return query.watch();
  }
}
