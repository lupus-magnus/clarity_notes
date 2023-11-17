import 'package:flutter/material.dart';
import 'package:hello_world/widgets/create_new_category_section.dart';
import 'package:hello_world/widgets/custom_app_bar.dart';
import 'package:hello_world/widgets/heading.dart';
import 'package:hello_world/widgets/or_divider.dart';
import 'package:hello_world/widgets/select_predefined_categories.dart';

class CreateCategorySetup extends StatelessWidget {
  const CreateCategorySetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  const Heading(text: "Criando um novo caderno"),
                  const SizedBox(height: 64),
                  const Heading(
                    text: "Nome do caderno",
                  ),
                  const SizedBox(height: 16),
                  CreateNewCategorySection(
                    redirectToWriteScreen: false,
                  ),
                  const OrDivider(),
                  const SelectPredefinedCategories()
                ]),
              )
            ])));
  }
}
