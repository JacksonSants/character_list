// import 'package:flutter/cupertino.dart';
// import 'package:personagem_list/components/character_card.dart';
//
// class CharacterInherited extends InheritedWidget {
//   CharacterInherited({
//     super.key,
//     required super.child,
//   });
//
//   final List<CharacterCard> characterList = [
//     CharacterCard("Ahri", "Vastiaya", 3, "assets/images/ahri.jpg", null),
//     CharacterCard("Ashe", "Humano", 5, "assets/images/ashe.jpg", null),
//     CharacterCard("Evelyn", "Demônio", 5, "assets/images/evelyn.jpg", null),
//     CharacterCard("Mordekaiser", "Humano", 5, "assets/images/mordekaiser.jpg", null),
//     CharacterCard("Kassadin", "Void", 5, "assets/images/kassadin.jpg", null),
//     CharacterCard("Teemo", "Yordle ", 5, "assets/images/teemo.jpg", null),
//   ];
//
//   void newCharacter(String name, String race, int strength, String image) {
//     characterList.add(CharacterCard(name, race, strength, image, null));
//   }
//
//   static CharacterInherited of(BuildContext context) {
//     final CharacterInherited? result =
//         context.dependOnInheritedWidgetOfExactType<CharacterInherited>();
//     assert(result != null, 'No characterInherited found in context');
//     return result!;
//   }
//
//   @override
//   bool updateShouldNotify(CharacterInherited old) {
//     return old.characterList.length != characterList.length;
//   }
// }
