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
            PersonagemCard("Ahri", "Vastiaya", 3, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4A8Cb-SnOTYQd8hyXMtFBJy0pJ4X36zZP1w&s"),
            PersonagemCard("Akali", "Humano", 5, "https://preview.redd.it/ic6a5b0ggfu81.jpg?auto=webp&s=a10d4216642122bd800aa16536f2c9a5b17ca6bb"),
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