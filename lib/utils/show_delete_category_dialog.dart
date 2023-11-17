import 'package:flutter/material.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/home_view.dart';
import 'package:provider/provider.dart';

showDeleteCategoryDialog(String categoryId, BuildContext context) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Tem certeza dessa operação?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ao deletar uma caderno, você perderá todas as anotações dele.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<UserDataProvider>()
                          .removeCategory(categoryId);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      );
                    },
                    child: const Text('Excluir caderno'),
                  ),
                ],
              ),
            ),
          ));
}
