import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';

import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:provider/provider.dart';

class ChooseNoteCategoryDialog extends StatelessWidget {
  const ChooseNoteCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    List<Category> categories = dataProvider.categories;

    return Dialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Escolha um caderno',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(height: 16),
            DropdownMenu(
              width: 240,
              hintText: "Selecionar",
              dropdownMenuEntries: categories
                  .map((category) => DropdownMenuEntry(
                        value: category.id,
                        label: category.name,
                      ))
                  .toList(),
              onSelected: (String? value) {
                if (value is String) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WriteView(
                        categoryId: value,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
