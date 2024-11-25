import 'package:flutter/cupertino.dart';
import 'package:personagem_list/components/character_card.dart';

class CharacterInherited extends InheritedWidget {
  CharacterInherited({
    super.key,
    required super.child,
  });

  final List<PersonagemCard> characterList = [
    PersonagemCard("Ahri", "Vastiaya", 3, "assets/images/ahri.jpg"),
    PersonagemCard("Ashe", "Humano", 5, "assets/images/ashe.jpg"),
    PersonagemCard("Evelyn", "Demônio", 5, "assets/images/evelyn.jpg"),
    PersonagemCard("Mordekaiser", "Humano", 5, "assets/images/mordekaiser.jpg"),
    PersonagemCard("Kassadin", "Void", 5, "assets/images/kassadin.jpg"),
    PersonagemCard("Teemo", "Yordle ", 5, "assets/images/teemo.jpg"),
  ];

  void newCharacter(String name, String race, int strength, String image){
    characterList.add(PersonagemCard(name, race, strength, image));
  }

  static CharacterInherited of(BuildContext context) {
    final CharacterInherited? result = context.dependOnInheritedWidgetOfExactType<CharacterInherited>();
    assert(result != null, 'No characterInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CharacterInherited old) {
    return old.characterList.length != characterList.length;
  }
}
