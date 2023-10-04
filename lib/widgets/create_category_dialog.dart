import 'package:flutter/material.dart';

import 'package:hello_world/providers/user_data.dart';
import 'package:provider/provider.dart';

class CreateCategoryDialog extends StatelessWidget {
  const CreateCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    void handleCreateCategory() {
      UserDataProvider dataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      String newCategoryValue = controller.text;
      bool categoryIsValid = newCategoryValue.isNotEmpty;
      if (categoryIsValid) {
        dataProvider.addCategory(newCategoryValue);
      }
    }

    return Dialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Qual categoria deseja criar?',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            TextField(
              controller: controller,
              cursorColor: Colors.black,
              autofocus: true,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20)),
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
                hintText: "Escreva aqui...",
                prefixIcon:
                    const Icon(Icons.add_circle_outline, color: Colors.black),
                contentPadding: const EdgeInsets.fromLTRB(24, 8, 16, 8),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  handleCreateCategory();
                },
                child: const Text('Criar categoria!')),
          ],
        ),
      ),
    );
  }
}
