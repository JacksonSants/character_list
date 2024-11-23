import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        title: Text("Lista de Personagens", style: TextStyle(color: Colors.white,),),
        backgroundColor: Colors.red,
      ),
      body: AnimatedOpacity(
        opacity: (opacity ? 1 : 0),
        duration: Duration(milliseconds: 1000),
        child: ListView(
          children: [
            PersonagemCard("Ahri", "Vastiaya", 3, "assets/images/ahri.jpg"),
            PersonagemCard("Ashe", "Humano", 5, "assets/images/ashe.jpg"),
            PersonagemCard("Evelyn", "Demônio", 5, "assets/images/evelyn.jpg"),
            PersonagemCard("Mordekaiser", "Humano", 5, "assets/images/mordekaiser.jpg"),
            PersonagemCard("Kassadin", "Void", 5, "assets/images/kassadin.jpg"),
            PersonagemCard("Teemo", "Yordle ", 5, "assets/images/teemo.jpg"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacity = !opacity;
          });
        },
        child: Icon(Icons.remove_red_eye),
      ),
    );
  }
}