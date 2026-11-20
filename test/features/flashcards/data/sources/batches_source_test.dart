import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flashcards/core/database/database.dart';
import 'package:flashcards/core/errors/result.dart';
import 'package:flashcards/features/flashcards/data/sources/batches_source.dart';
import 'package:flashcards/features/flashcards/domain/use_cases/batches/update_batch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late BatchesSource source;

  setUp(() {
    db = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    source = BatchesSourceImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('A batch is created successfully', () async {
    final result = await source.createBatch('Batch 1');

    expect(result, isA<Success>());

    final batch = result.valueOrNull!;

    expect(batch.id, 1);
    expect(batch.name, 'Batch 1');
    expect(batch.isArchived, isFalse);

    final batchFromDb = await (db.select(
      db.batchTable,
    )..where((tbl) => tbl.id.equals(1))).getSingle();

    expect(batchFromDb.id, 1);
    expect(batchFromDb.name, 'Batch 1');
    expect(batchFromDb.isArchived, isFalse);
  });

  test('A batch is deleted successfully', () async {
    final batchFromDb = await db
        .into(db.batchTable)
        .insertReturning(BatchTableCompanion.insert(name: 'Batch 1'));

    final delRes = await source.deleteBatch(batchFromDb.id);

    expect(delRes, isA<Success>());

    final batches = await (db.select(db.batchTable)).get();

    expect(batches, isEmpty);
  });

  test('Batch deletion failure', () async {
    final batchFromDb = await (db.select(
      db.batchTable,
    )..where((tbl) => tbl.id.equals(1))).getSingleOrNull();

    expect(batchFromDb, isNull);

    final delRes = await source.deleteBatch(1);

    expect(delRes, isA<Failure>());
  });

  test('A batch is updated successfully', () async {
    final batchToDb = await db
        .into(db.batchTable)
        .insertReturning(BatchTableCompanion.insert(name: 'Batch 1'));

    final updatedBatchRes = await source.updateBatch(
      UpdateBatchParams(id: batchToDb.id, name: 'Batch Updated'),
    );

    expect(updatedBatchRes, isA<Success>());

    final updatedBatch = updatedBatchRes.valueOrNull!;

    expect(updatedBatch.id, batchToDb.id);
    expect(updatedBatch.name, 'Batch Updated');

    final batchFromDb = await (db.select(
      db.batchTable,
    )..where((tbl) => tbl.id.equals(updatedBatch.id))).getSingle();

    expect(batchFromDb.name, 'Batch Updated');
  });

  test('Batch update failure', () async {
    final batchFromDb = await (db.select(
      db.batchTable,
    )..where((tbl) => tbl.id.equals(1))).getSingleOrNull();

    expect(batchFromDb, isNull);

    final updatedBatchRes = await source.updateBatch(
      UpdateBatchParams(id: 1, name: 'Batch Updated'),
    );

    expect(updatedBatchRes, isA<Failure>());
  });
}
