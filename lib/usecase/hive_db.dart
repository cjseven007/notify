import 'package:hive/hive.dart';
import 'package:notify/entity/note_entity.dart';

class HiveDB {
  final _myBox = Hive.box("notes");

  // load notes
  List<NoteEntity> loadNotes() {
    List<NoteEntity> savedNotesFormatted = [];

    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        NoteEntity individualNote = NoteEntity(
            id: savedNotes[i][0],
            title: savedNotes[i][1],
            content: savedNotes[i][2],
            createdAt: savedNotes[i][3]);

        savedNotesFormatted.add(individualNote);
      }
    }
    return savedNotesFormatted;
  }

  void saveNotes(List<NoteEntity> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];
    for (var note in allNotes) {
      String id = note.id;
      String title = note.title;
      String content = note.content;
      DateTime createdAt = note.createdAt;

      allNotesFormatted.add([id, title, content, createdAt]);
    }
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
