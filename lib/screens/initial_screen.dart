import 'package:flutter/material.dart';
import 'package:personagem_list/screens/form_screen.dart';
import '../components/character_card.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lista de Personagens",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: const [
          PersonagemCard("Ahri", "Vastiaya", 3, "assets/images/ahri.jpg"),
          PersonagemCard("Ashe", "Humano", 5, "assets/images/ashe.jpg"),
          PersonagemCard("Evelyn", "Demônio", 5, "assets/images/evelyn.jpg"),
          PersonagemCard(
              "Mordekaiser", "Humano", 5, "assets/images/mordekaiser.jpg"),
          PersonagemCard("Kassadin", "Void", 5, "assets/images/kassadin.jpg"),
          PersonagemCard("Teemo", "Yordle ", 5, "assets/images/teemo.jpg"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
