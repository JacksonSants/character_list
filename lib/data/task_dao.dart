class CharacterDao {
  // Add your SQL table creation query here
  static const String sqlTable = "CREATE TABLE $_characterTable("
      "$_name TEXT,"
      "$_race TEXT,"
      "$_strength INTEGER,"
      "$_image TEXT)";

  static const String _characterTable = "Character";

  static const String _name = "name";
  static const String _race = "race";
  static const String _strength = "strength";
  static const String _image = "image";
}
