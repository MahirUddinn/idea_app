import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akjfkgnjkawgnf/cubit/notes_cubit.dart';
import 'package:akjfkgnjkawgnf/data/database_helper.dart';
import 'package:akjfkgnjkawgnf/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => NotesCubit(DatabaseHelper())..loadNotes(),
        child: HomeScreen(),
      ),
    );
  }
}