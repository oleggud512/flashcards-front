import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

const _dbName = 'my_database';

@DataClassName('BatchDbModel')
class BatchTable extends Table {
  @override
  String get tableName => 'batch';

  late final id = integer().autoIncrement()();
  late final isArchived = boolean().withDefault(Constant(false))();
  late final name = text()();
  late final createdAt = dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('RequestDbModel')
class RequestTable extends Table {
  @override
  String get tableName => 'request';

  late final id = integer().autoIncrement()();
  late final word = text()();
  late final additionalParams = text()();
}

@DataClassName('CardSetDbModel')
class CardSetTable extends Table {
  @override
  String get tableName => 'card_set';

  late final id = integer().autoIncrement()();
  late final createdAt = dateTime().withDefault(currentDateAndTime)();
  late final requestId = integer().references(RequestTable, #id)();
}

@DataClassName('CardDbModel')
class CardTable extends Table {
  @override
  String get tableName => 'card';

  late final id = integer().autoIncrement()();
  late final front = text()();
  late final back = text()();
  late final cardSetId = integer().references(CardSetTable, #id)();
}

@DataClassName('BatchCardSetDbModel')
class BatchCardSetTable extends Table {
  @override
  String get tableName => 'batch_card_set';

  @override
  Set<Column<Object>>? get primaryKey => {cardSetId, batchId};

  late final cardSetId = integer().references(CardSetTable, #id)();
  late final batchId = integer().references(BatchTable, #id)();
}

@DataClassName('PendingBatchCardSetDbModel')
class PendingBatchCardSetTable extends Table {
  @override
  String get tableName => 'pending_batch_card_set';

  @override
  Set<Column<Object>>? get primaryKey => {requestId, batchId};

  late final requestId = integer().references(RequestTable, #id)();
  late final batchId = integer().references(BatchTable, #id)();
}

enum GenerationTaskTableStatus {
  pending,
  inProgress,
  completed,
  failed,
  canceled,
}

@DataClassName('GenerationTaskDbModel')
class GenerationTaskTable extends Table {
  @override
  String get tableName => 'generation_task';

  late final id = integer().autoIncrement()();
  late final requestId = integer().references(RequestTable, #id)();
  late final status = textEnum<GenerationTaskTableStatus>()();
  late final errorMessage = text().nullable()();

  late final createdAt = dateTime().withDefault(currentDateAndTime)();
  late final startedAt = dateTime().nullable()();
  late final completedAt = dateTime().nullable()();
}

@DriftDatabase(
  tables: [
    BatchTable,
    RequestTable,
    CardSetTable,
    CardTable,
    BatchCardSetTable,
    PendingBatchCardSetTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  new([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: _dbName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<void> deleteDb() async {
    await close();

    final directory = await getApplicationSupportDirectory();
    final dbPath = p.join(directory.path, '$_dbName.sqlite');

    final dbFile = File(dbPath);

    if (await dbFile.exists()) {
      await dbFile.delete();
    }

    final walFile = File('$dbPath-wal');
    if (await walFile.exists()) {
      await walFile.delete();
    }

    final shmFile = File('$dbPath-shm');
    if (await shmFile.exists()) {
      await shmFile.delete();
    }

    final journalFile = File('$dbPath-journal');
    if (await journalFile.exists()) {
      await journalFile.delete();
    }
  }
}
