import 'package:flutter/material.dart';
import 'package:notify/components/note_card.dart';
import 'package:notify/entity/note_entity.dart';
import 'package:notify/usecase/note_usecase.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Future<void> _showNoteDialog(BuildContext ctx) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    return showDialog<void>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  NoteEntity newNote = NoteEntity(
                    title: titleController.text,
                    content: contentController.text,
                  );

                  NoteUsecase provider =
                      Provider.of<NoteUsecase>(context, listen: false);
                  provider.addNote(newNote);
                }
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    NoteUsecase provider = Provider.of<NoteUsecase>(context, listen: false);
    provider.initializeNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteUsecase>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "Notify",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: provider.allNotes.isEmpty
              ? const Center(child: Text("Empty"))
              : ListView.builder(
                  itemCount: provider.allNotes.length,
                  itemBuilder: (context, index) {
                    NoteEntity item = provider.allNotes[index];
                    return NoteCard(note: item);
                  },
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Icon(Icons.add),
            onPressed: () {
              _showNoteDialog(context);
            },
          ),
        );
      },
    );
  }
}
