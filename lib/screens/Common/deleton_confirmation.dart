import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
    BuildContext context, {
      String title = "Atenção!",
      String content = "Você deseja executar esta operação?",
      String affirmativeOption = "Confirmar",
    }) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(affirmativeOption.toUpperCase()),
          ),
        ],
      );
    },
  );
}
