import 'package:flutter/material.dart';
import 'package:personagem_list/components/character_card.dart';
import 'package:personagem_list/data/character_inherited.dart';
import 'package:personagem_list/data/character_dao.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({required this.characterContext, super.key});

  final BuildContext characterContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController raceController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController strengthController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  valueValidate(String? value){
    if(value != null && value.isEmpty){
      return true;
    }

    return false;
  }

  lifePointValidator(String? value){
    if(value!.isEmpty && value.isEmpty){
      if(int.parse(value) < 1 ||
          int.parse(value) > 100){
        return true;
      }
    }

    return false;
  }

  strengthValidator(String? value){
    if(value!.isEmpty && value.isEmpty){
      if(int.parse(value) < 1 ||
          int.parse(value) > 5){
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Formulário de personagem",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          color: Colors.red[100],
          child: Center(
            child: Container(
              width: 400,
              height: 650,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (valueValidate(value)) {
                            return "Campo de nome vazio.";
                          }
                          return null;
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
                          if (valueValidate(value)) {
                            return "Campo de raça vazio";
                          }
                          return null;
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
                          if (strengthValidator(value)) {
                            return "Preencha o campo de força de vida entre 1 e 5.";
                          }
                          return null;
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
                          if (valueValidate(value)) {
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
                              return Image.asset("assets/images/no_image.png",
                                fit: BoxFit.cover,);
                            },),
                        )
                    ),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          CharacterDao().saveCharacter(CharacterCard(nameController.text, raceController.text, int.parse(strengthController.text), urlController.text, null));

                          //CharacterInherited.of(widget.characterContext).newCharacter(nameController.text, raceController.text, int.parse(strengthController.text), urlController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Personagem salvo."), backgroundColor: Colors.green,)
                          );

                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
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
