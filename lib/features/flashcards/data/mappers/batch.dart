import 'package:flashcards/core/database/database.dart';
import 'package:flashcards/features/flashcards/domain/entities/batch_entity.dart';

extension BatchMapper on BatchDbModel {
  BatchEntity toDomain() => BatchEntity(
    id: id,
    isArchived: isArchived,
    createdAt: createdAt,
    name: name,
  );
}
