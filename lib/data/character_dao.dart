import 'package:personagem_list/components/character_card.dart';
import 'package:personagem_list/data/database.dart';
import 'package:sqflite/sqflite.dart';

class CharacterDao {
  // Add your SQL table creation query here
  static const String sqlTable = "CREATE TABLE $_characterTable("
      "$_id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$_name TEXT,"
      "$_race TEXT,"
      "$_strength INTEGER,"
      "$_image TEXT)";


  static const String _characterTable = "Character";

  static const String _name = "name";
  static const String _race = "race";
  static const String _strength = "strength";
  static const String _image = "image";
  static const String _id = "id";


  saveCharacter(CharacterCard character) async{
    print("Iniciando saveCharacter...");
    final Database db = await getDatabase();
    var itemExists = await findOneCharacter(character.name);
    Map<String, dynamic> characterMap = toMap(character);

    if(itemExists.isEmpty){
      print("Personagem não encontrado.");
      return await db.insert(_characterTable, characterMap);
    }
    else{
      print("Tarefa já existe...");
    }
  }

  // updateCharacter(CharacterCard character) async {
  //   print("Iniciando updateCharacter...");
  //   final Database db = await getDatabase();
  //   var itemExists = await findOneCharacter(character.id);
  //   Map<String, dynamic> characterMap = toMap(character);
  //
  //   if (itemExists.isNotEmpty) {
  //     print("Personagem encontrado. Realizando atualização.");
  //     return await db.update(
  //       _characterTable,
  //       characterMap,
  //       where: "id = ?",
  //       whereArgs: [character.id],
  //     );
  //   } else {
  //     print("Personagem não encontrado...");
  //   }
  // }

  Future<List<CharacterCard>> findAllCharacter() async{
    print("Acessando findAll...");
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_characterTable);
    return toList(result);
  }

  Future<List<CharacterCard>> findOneCharacter(String characterName) async{
    print("Acessando findOneCharacter...");
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_characterTable, where: "$_name = ?", whereArgs: [characterName]);
    print("Personagem encontrado: $result");
    return toList(result);
  }

  deleteCharacter(String characterName) async{
    print("Deletando um personagem $characterName...");
    final Database db = await getDatabase();
    db.delete(
      _characterTable,
      where: "$_name = ?",
      whereArgs: [characterName]
    );
  }

  List<CharacterCard> toList(List<Map<String, dynamic>> characterMap) {
    print("Acessando o toList...");
    final List<CharacterCard> characters = [];

    print("Percorrendo o mapa de dados");
    for(Map<String,dynamic> linha in characterMap){
      final CharacterCard character = CharacterCard(
          linha[_name],
          linha[_race],
          linha[_strength],
          linha[_image],
          linha[_id],
      );
      characters.add(character);
    }
    print("Lista de personagem $characterMap");
    return characters;

  }

  Map<String, dynamic> toMap(CharacterCard character){
    print("Convertando para Map");
    Map<String, dynamic> characterMap = Map();
    characterMap[_name] = character.name;
    characterMap[_race] = character.race;
    characterMap[_strength] = character.strength;
    characterMap[_image] = character.url;
    print("Mapa de tarefas: $characterMap");
    return characterMap;
  }

}
