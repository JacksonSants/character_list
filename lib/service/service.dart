import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:personagem_list/components/character_card.dart';

import 'http_interceptor.dart';

class CharacterService {
  static const String url = "http://localhost:3000/";
  static const String resource = "serverhttp/";

  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  String getUrl() {
    return "$url$resource";
  }

  Future<bool> register(CharacterCard character) async {
    String jsonPersonagem = json.encode(character.toMap());
    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {
        'Content-type': "application/json",
      },
      body: jsonPersonagem,
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<List<CharacterCard>> getAllCharacters() async {
    try {
      http.Response response = await client.get(Uri.parse(getUrl()));

      if (response.statusCode != 200) {
        throw HttpException(
            "Erro ao buscar personagens. Código: ${response.statusCode}");
      }

      List<dynamic> personagensDynamic = json.decode(response.body);

      return personagensDynamic.map((jMap) => CharacterCard.fromMap(jMap)).toList();
    } catch (e) {
      print("Erro no getAllCharacters: $e");
      rethrow;
    }
  }

  Future<bool> deleteCharacter(int id) async {
    http.Response response = await client.delete(
      Uri.parse("${getUrl()}$id"),
      headers: {
        'Content-type': "application/json",
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}