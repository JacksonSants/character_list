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
          future: CharacterDao().findAllCharacter(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Carregando..."),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && snapshot.data != null) {
                  final items = snapshot.data!;
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final CharacterCard character = items[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(
                              character.url,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.image_not_supported),
                            ),
                            title: Text(character.name),
                            subtitle: Text('Raça: ${character.race} | Força: ${character.strength}'),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          "Sem personagem...",
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 128),
                      Text(
                        "Erro ao carregar personagens",
                        style: TextStyle(fontSize: 32),
                      ),
                    ],
                  ),
                );
              default:
                return Text("Erro desconhecido");
            }
          },
        ),
      ),

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
