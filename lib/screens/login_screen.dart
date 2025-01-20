import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personagem_list/screens/initial_screen.dart';
import 'package:personagem_list/screens/register_screen.dart';
import 'package:personagem_list/service/service.dart';

import '../service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize: 35, color: Colors.red)),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Preencha o campo de e-mail.";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: Colors.red),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Preencha o campo de senha.";
                  }
                  return null;
                },
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: Colors.red),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  AuthService auth = AuthService();

                  bool isLoggedIn = await auth.login(emailController.text, passwordController.text);

                  if (isLoggedIn) {
                    String? token = await auth.getToken();

                    if (token != null) {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (newContext) => InitialScreen(token: token)),
                      );
                      print("Serviço de personagem inicializado.");
                    } else {
                      print("Erro: token não encontrado após o login.");
                    }
                  } else {
                    print("Falha no login.");
                  }
                },


                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login, color: Colors.white),
                    SizedBox(width: 8.0),
                    Text('Entrar', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Não possui conta?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(
                      " Registrar-se",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
