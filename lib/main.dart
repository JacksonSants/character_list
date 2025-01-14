import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:personagem_list/screens/login_screen.dart';
import 'package:personagem_list/service/service.dart';

void main() {
  runApp(const MyApp());
  CharacterService service = CharacterService();
  service.getAllCharacters();
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
        home: Container(child: LoginScreen()),
    );
  }
}
