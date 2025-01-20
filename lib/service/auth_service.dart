import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_interceptor.dart';

class AuthService {
  static const String url = "http://localhost:3000/";
  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  Future<bool> register(String email, String password) async {
    try {
      print("email: $email\nsenha: $password");
      http.Response response = await client.post(
        Uri.parse("${url}register"),
        body:{
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode != 201) {
        print("Falha ao cadastrar usuário: ${response.body}");
        return false;
      } else {
        print("Usuário cadastrado com sucesso!");
        return true;
      }
    } catch (e) {
      print("Erro durante o cadastro: $e");
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      http.Response response = await client.post(
        Uri.parse("${url}login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['accessToken'];
        print("Token recebido: $token");
        return true;
      } else {
        print("Falha ao fazer login: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Erro durante o login: $e");
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    return token != null;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    print("Usuário deslogado com sucesso!");
  }

}
