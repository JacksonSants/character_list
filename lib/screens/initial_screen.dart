import 'package:flutter/material.dart';
import 'package:personagem_list/components/character_card.dart';
import 'package:personagem_list/data/character_dao.dart';
import 'package:personagem_list/screens/form_screen.dart';
import '../data/character_inherited.dart';

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
        leading: Container(),
        actions: [
          IconButton(onPressed: (){
            setState(() {

            });
          }, icon: Icon(Icons.refresh, color: Colors.white,))
        ],
        title: const Text(
          "Lista de Personagens",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(padding: const EdgeInsets.only(top: 8, bottom: 70),
      child: FutureBuilder<List<CharacterCard>>(
        future:  CharacterDao().findAllCharacter(), builder: (context, snapshot){
          List<CharacterCard>? items = snapshot.data;
          switch (snapshot.connectionState){

            case ConnectionState.none:
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text("Carregando...")
                  ],
                ),
              );
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text("Carregando...")
                  ],
                ),
              );
            case ConnectionState.active:
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text("Carregando...")
                  ],
                ),
              );
            case ConnectionState.done:
              if(snapshot.hasData && items != null){
                if(items.isNotEmpty){
                  return ListView.builder(itemCount: items.length, itemBuilder: (BuildContext context, int index){
                    final CharacterCard character = items[index];
                    return character;
                  });
                }
                return Center(
                  child: Column(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 128,),
                      Text("Sem personagem...", style:  TextStyle(fontSize:  32),)
                    ],
                  ),
                );
              }
              return Text("Erro ao carregar tarefa");
          }
          return Text("Erro desconhecido");

      },
      ),),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        splashColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (newContext) => FormScreen(
                      characterContext: context,
                    )),
          ).then((value) => setState(() {
            print("Recarregando a tela inicial");
          }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
    );
  }
}
