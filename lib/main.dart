import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:personagem_list/components/character_card.dart';
import 'package:personagem_list/screens/initial_screen.dart';
import 'package:personagem_list/service/service.dart';

import 'data/character_inherited.dart';

void main() {
  runApp(const MyApp());
  CharacterService service = CharacterService();
  service.getAllCharacters();
  CharacterCard character = CharacterCard("Evelyn", "Demoônio", 4, "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Evelynn_3.jpg", 2);
  service.register(character);
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
