import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  var nameController = TextEditingController();
  var raceController = TextEditingController();
  var nomeController = TextEditingController();
  var lifePointController = TextEditingController();
  var strengthController = TextEditingController();
  var urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Formulário de personagem",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.red[100],
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 400,
              height: 650,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameController,

                      decoration: const InputDecoration(
                          hintText: "Nome do personagem...",
                          hintStyle: TextStyle(color: Colors.black38,
                          ),
                          filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: raceController,
                      decoration: const InputDecoration(
                          hintText: "Raça do personagem...",
                          hintStyle: TextStyle(color: Colors.black38),
                          filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: lifePointController,
                      decoration: const InputDecoration(
                          hintText: "Pontos de vida...",
                          hintStyle: TextStyle(color: Colors.black38),
                          filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: strengthController,
                      decoration: const InputDecoration(
                          hintText: "Força do personagem...",
                          hintStyle: TextStyle(color: Colors.black38),
                          filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text){
                        setState(() {
                        });
                      },
                      controller: urlController,
                      decoration: const InputDecoration(
                          hintText: "URL da foto do personagem...",
                          hintStyle: TextStyle(color: Colors.black38),
                          filled: true),
                    ),
                  ),
                  Container(
                      width: 130,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(5),),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(urlController.text, fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                            return Image.asset("assets/images/no_image.jpg", fit: BoxFit.cover,);
                          },),
                      )
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("Nome: ${nameController.text}");
                      print("Raça: ${raceController.text}");
                      print("Pontos de vida: ${int.parse(lifePointController.text)}");
                      print("Força: ${int.parse(strengthController.text)}");
                      print("url: ${urlController.text}");
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: const Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
