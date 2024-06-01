import 'package:uuid/uuid.dart';

class NoteEntity {
  String id;
  String title;
  String content;
  DateTime createdAt;

  NoteEntity({
    String? id,
    required this.title,
    required this.content,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();
}
