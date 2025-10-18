import 'package:akjfkgnjkawgnf/screen/home_screen.dart';
import 'package:flutter/material.dart';

class IdeaApp extends StatelessWidget {
  const IdeaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.dark,
        home: HomeScreen());
  }
}
