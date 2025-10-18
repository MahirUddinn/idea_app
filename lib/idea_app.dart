import 'package:akjfkgnjkawgnf/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akjfkgnjkawgnf/cubit/notes_cubit.dart';
import 'package:akjfkgnjkawgnf/data/app_database.dart';

class IdeaApp extends StatelessWidget {
  const IdeaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',

      themeMode: ThemeMode.dark,
      home: BlocProvider(
        create: (context) => NotesCubit(AppDatabase()),
        child: HomeScreen(),
      ),
    );
  }
}