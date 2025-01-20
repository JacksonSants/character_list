import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:personagem_list/components/character_card.dart';

import 'http_interceptor.dart';

class CharacterService {
  static const String url = "http://localhost:3000/";
  static const String resource = "serverhttp/";

  final String token;
  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  CharacterService(this.token);

  String getUrl() {
    return "$url$resource";
  }

  Future<List<CharacterCard>> getAllCharacters() async {
    try {
      http.Response response = await client.get(
        Uri.parse(getUrl()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

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

  Future<bool> register(CharacterCard character) async {
    try {
      // Converte o objeto CharacterCard em JSON
      String jsonPersonagem = json.encode(character.toMap());

      // Faz a requisição POST com o token no cabeçalho
      http.Response response = await client.post(
        Uri.parse(getUrl()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Inclui o token para autenticação
        },
        body: jsonPersonagem,
      );

      // Verifica o status da resposta
      if (response.statusCode == 201) {
        print("Personagem registrado com sucesso.");
        return true;
      } else {
        print("Erro ao registrar personagem. Código: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Erro no método register: $e");
      return false;
    }
  }


  // Future<List<CharacterCard>> getAllCharacters() async {
  //   try {
  //     http.Response response = await client.get(Uri.parse(getUrl()));
  //
  //     if (response.statusCode != 200) {
  //       throw HttpException(
  //           "Erro ao buscar personagens. Código: ${response.statusCode}");
  //     }
  //
  //     List<dynamic> personagensDynamic = json.decode(response.body);
  //
  //     return personagensDynamic.map((jMap) => CharacterCard.fromMap(jMap)).toList();
  //   } catch (e) {
  //     print("Erro no getAllCharacters: $e");
  //     rethrow;
  //   }
  // }

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