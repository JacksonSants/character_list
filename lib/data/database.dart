import 'package:personagem_list/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'character.db');

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      // Creating the table
      return db.execute(CharacterDao.sqlTable);
    },
  );
}
