import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/home_view.dart';
import 'package:hello_world/utils/show_delete_category_dialog.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:hello_world/widgets/custom_app_bar.dart';
import 'package:hello_world/widgets/heading.dart';
import 'package:hello_world/widgets/input_text.dart';
import 'package:hello_world/widgets/notebook_more_options_menu.dart';
import 'package:hello_world/widgets/or_divider.dart';

import 'package:provider/provider.dart';

class EditCategory extends StatefulWidget {
  final Category category;
  const EditCategory({super.key, required this.category});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  String? currentCover;

  @override
  void initState() {
    super.initState();
    currentCover = widget.category.cover;
  }

  handleUpdateCover(String newCover) {
    setState(() {
      currentCover = newCover;
    });
  }

  handleEditButtonPress(
    BuildContext context, {
    required String newName,
    // required String newCover,
    required String newDescription,
  }) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    dataProvider.updateCategory(
      widget.category.id,
      newName: newName,
      newDescription: newDescription,
      newCover: currentCover,
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController =
        TextEditingController(text: widget.category.description);
    TextEditingController controller =
        TextEditingController(text: widget.category.name);

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
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
                  NotebookMoreOptionsMenu(
                    controller: descriptionController,
                    currentSelectedCover: currentCover,
                    setCurrentCover: handleUpdateCover,
                  ),
                  const SizedBox(height: 16),
                  Button(
                      text: "SALVAR",
                      onPressed: () {
                        handleEditButtonPress(
                          context,
                          newName: controller.text,
                          newDescription: descriptionController.text,
                        );
                      }),
                  const OrDivider(),
                  Button(
                    text: "EXCLUIR",
                    onPressed: () {
                      showDeleteCategoryDialog(widget.category.id, context);
                    },
                    outlined: true,
                  )
                ]),
              )
            ])));
  }
}
