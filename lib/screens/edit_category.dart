import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/home_view.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:hello_world/widgets/heading.dart';
import 'package:hello_world/widgets/input_text.dart';
import 'package:hello_world/widgets/or_divider.dart';
import 'package:hello_world/widgets/template_cover.dart';
import 'package:provider/provider.dart';

class EditCategory extends StatefulWidget {
  final Category category;
  const EditCategory({super.key, required this.category});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  handleEditButtonPress(BuildContext context, String newValue) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    dataProvider.updateCategory(widget.category.id, newName: newValue);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  handleDeleteButtonPress(BuildContext context) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
                        Navigator.pop(context);
                        dataProvider.removeCategory(widget.category.id);
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

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: widget.category.name);
    return Scaffold(
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              const TemplateCover(
                renderBacklink: true,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  const Heading(text: "Editar caderno"),
                  const SizedBox(height: 64),
                  const Heading(
                    text: "Nome do caderno:",
                  ),
                  const SizedBox(height: 16),
                  InputText(controller: controller, onChanged: (value) {}),
                  const SizedBox(height: 16),
                  Button(
                      text: "SALVAR",
                      onPressed: () {
                        handleEditButtonPress(context, controller.text);
                      }),
                  const OrDivider(),
                  Button(
                    text: "EXCLUIR",
                    onPressed: () {
                      handleDeleteButtonPress(context);
                    },
                    outlined: true,
                  )
                ]),
              )
            ])));
  }
}
