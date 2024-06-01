import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notify/pages/note_page.dart';
import 'package:notify/usecase/note_usecase.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("notes");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteUsecase(),
        )
      ],
      child: const MaterialApp(
        color: Colors.blue,
        debugShowCheckedModeBanner: false,
        home: NotePage(),
      ),
    );
  }
}
