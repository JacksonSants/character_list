import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import 'initial_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();


  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("As senhas não coincidem.")),
        );
        return;
      }
      bool success = await authService.register(email, password);

      if (success) {
        final token = await authService.getToken();

        if (token != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (newContext) => InitialScreen(token: token),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Cadastro realizado com sucesso!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Falha ao recuperar o token. Faça login novamente.")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Falha no cadastro. Tente novamente.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cadastro"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Cadastro", style: TextStyle(fontSize: 35, color: Colors.red)),
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
                  if (value.length < 6) {
                    return "A senha deve ter pelo menos 6 caracteres.";
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
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirme sua senha.";
                  }
                  return null;
                },
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
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
                onPressed: _signUp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add, color: Colors.white),
                    SizedBox(width: 8.0),
                    Text('Cadastrar', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
