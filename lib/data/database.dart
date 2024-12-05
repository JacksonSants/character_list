import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:personagem_list/data/character_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'character.db');

  // Exclui o banco de dados se ele existir
  //await deleteDatabase(path);

  // Cria o banco de dados novamente
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      return db.execute(CharacterDao.sqlTable);
    },
  );
}
