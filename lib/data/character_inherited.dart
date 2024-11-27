import 'package:flutter/cupertino.dart';
import 'package:personagem_list/components/character_card.dart';

class CharacterInherited extends InheritedWidget {
  CharacterInherited({
    super.key,
    required super.child,
  });

  final List<CharacterCard> characterList = [
    CharacterCard("Ahri", "Vastiaya", 3, "assets/images/ahri.jpg"),
    CharacterCard("Ashe", "Humano", 5, "assets/images/ashe.jpg"),
    CharacterCard("Evelyn", "Demônio", 5, "assets/images/evelyn.jpg"),
    CharacterCard("Mordekaiser", "Humano", 5, "assets/images/mordekaiser.jpg"),
    CharacterCard("Kassadin", "Void", 5, "assets/images/kassadin.jpg"),
    CharacterCard("Teemo", "Yordle ", 5, "assets/images/teemo.jpg"),
  ];

  void newCharacter(String name, String race, int strength, String image) {
    characterList.add(CharacterCard(name, race, strength, image));
  }

  static CharacterInherited of(BuildContext context) {
    final CharacterInherited? result =
        context.dependOnInheritedWidgetOfExactType<CharacterInherited>();
    assert(result != null, 'No characterInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CharacterInherited old) {
    return old.characterList.length != characterList.length;
  }
}
