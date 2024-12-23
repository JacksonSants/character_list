import 'package:flutter/material.dart';
import 'package:personagem_list/components/character_card.dart';
import 'package:personagem_list/data/character_dao.dart';
import 'package:personagem_list/screens/form_screen.dart';
import 'package:personagem_list/service/service.dart';
import '../data/character_inherited.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  final CharacterService characterService = CharacterService();

  Future<List<CharacterCard>> _getAll() async {
    return await characterService.getAllCharacters();
  }

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
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<CharacterCard>>(
          future: _getAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar personagens: ${snapshot.error}'),
                  );
                }

                if (snapshot.hasData && snapshot.data != null) {
                  final character = snapshot.data!;
                  if (character.isNotEmpty) {
                    return ListView.builder(
                      itemCount: character.length,
                      itemBuilder: (context, index) {
                        final currentCharacte = character[index];
                        return CharacterCard(
                          currentCharacte.name,
                          currentCharacte.race,
                          currentCharacte.strength,
                          currentCharacte.url,
                          currentCharacte.id,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 128),
                          Text(
                            'Não há nenhum personagem.',
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Erro ao carregar personagens.'),
                  );
                }

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
