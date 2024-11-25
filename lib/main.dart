import 'package:flutter/material.dart';
import 'package:personagem_list/screens/initial_screen.dart';

import 'data/character_inherited.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Alura Quest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: CharacterInherited(child: const InitialScreen()),
    );
  }
}
