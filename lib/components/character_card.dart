import 'package:flutter/material.dart';
import 'package:personagem_list/components/strength_status.dart';
import 'package:personagem_list/data/character_dao.dart';
import 'package:personagem_list/screens/modal_add_form.dart';

class CharacterCard extends StatefulWidget {
  final String name;
  final String race;
  final int strength;
  final String url;
  final int? id;

  CharacterCard(this.name, this.race, this.strength, this.url, this.id,{super.key});

  int lifePoint = 100;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool assetOrNetwork() {
    if (widget.url.contains("http")) {
      return false;
    }
    return true;
  }

  void _deleteCharacter() async {
    bool isDeleted = await CharacterDao().deleteCharacter(widget.name);

    if (isDeleted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Personagem removido com sucesso."))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Falha ao remover o personagem."))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              height: 170,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10)),
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 120,
                            color: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: assetOrNetwork()
                                  ? Image.asset(
                                      widget.url,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      widget.url,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  widget.race,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400),
                                ),
                                StrengthBar(strengthstatus: widget.strength)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.center,
                                          backgroundColor: Colors.red),
                                      onPressed: () {
                                        _showEditForm(context, widget.id);
                                      },
                                      child: const Icon(Icons.edit, color: Colors.white, size: 15,)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.center,
                                          backgroundColor: Colors.red),
                                      onPressed: () {
                                        CharacterDao().deleteCharacter(widget.name);
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Personagem removido com sucesso. Recarre as informações para vizualizar as alterações."), backgroundColor: Colors.green,));
                                      },
                                      child: const Icon(Icons.remove, color: Colors.white, size: 15,)),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.center),
                                      onPressed: () {
                                        setState(() {
                                          widget.lifePoint++;
                                          if (widget.lifePoint > 100) {
                                            widget.lifePoint = 100;
                                          }
                                        });
                                      },
                                      child: const Icon(Icons.arrow_drop_up)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.center),
                                      onPressed: () {
                                        setState(() {
                                          widget.lifePoint--;
                                          if (widget.lifePoint < 0) {
                                            widget.lifePoint = 0;
                                          }
                                        });
                                      },
                                      child: const Icon(Icons.arrow_drop_down)),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 230,
                          child: LinearProgressIndicator(
                            color: Colors.orange,
                            value: widget.lifePoint / 100,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Vida: ${widget.lifePoint}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _showEditForm(BuildContext context, int? id) {
  final nameController = TextEditingController();
  final raceController = TextEditingController();
  final strengthController = TextEditingController();
  final urlController = TextEditingController();

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

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Form(
        key: _formKey,
        child: AlertDialog(
          title: const Text('Editar Personagem'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (String? value) {
                    if (valueValidate(value)) {
                      return "Campo de nome vazio.";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Nome...",
                  ),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (valueValidate(value)) {
                      return "Campo de raça vazio.";
                    }
                    return null;
                  },
                  controller: raceController,
                  decoration: const InputDecoration(
                      hintText: "Raça..."
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (strengthValidator(value)) {
                      return "Preencha o campo de força de vida entre 1 e 5.";
                    }
                    return null;
                  },
                  controller: strengthController,
                  decoration: const InputDecoration(
                      hintText: "Força..."
                  ),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (valueValidate(value)) {
                      return "Campo de nome vazio.";
                    }
                    return null;
                  },
                  controller: urlController,
                  decoration: const InputDecoration(
                      hintText: "Url da imagem..."
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o dialog
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){

                }
                Navigator.of(context).pop(); // Fecha o dialog após salvar
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      );
    },
  );
}
