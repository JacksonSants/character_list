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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value != null && value!.isEmpty) {
                            return "Campo de nome vazio.";
                          }
                        },
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
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Campo de raça vazio";
                          }
                        },
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
                        validator: (value) {
                          if (value!.isEmpty || int.parse(value) < 1 ||
                              int.parse(value) > 100) {
                            return "Preencha o campo de pontos de vida entre 1 e 100.";
                          }
                        },
                        keyboardType: TextInputType.number,
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
                        validator: (value) {
                          if (value!.isEmpty || int.parse(value) < 1 ||
                              int.parse(value) > 5) {
                            return "Preencha o campo de força de vida entre 1 e 5.";
                          }
                        },
                        keyboardType: TextInputType.number,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Preencha o campo imagem com uma URL válida.";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        onChanged: (text) {
                          setState(() {});
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
                          child: Image.network(urlController.text, fit: BoxFit
                              .cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset("assets/images/no_image.jpg",
                                fit: BoxFit.cover,);
                            },),
                        )
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(nameController.text);
                          print(raceController.text);
                          print(lifePointController.text);
                          print(strengthController.text);
                          print(urlController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Personagem salvo."))
                          );
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.red)),
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
      ),
    );
  }
}
