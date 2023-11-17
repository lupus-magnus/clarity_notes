import 'package:flutter/material.dart';
import 'package:hello_world/providers/user_data.dart';

import 'package:hello_world/widgets/create_new_category_section.dart';
import 'package:hello_world/widgets/custom_app_bar.dart';

import 'package:hello_world/widgets/heading.dart';

import 'package:hello_world/widgets/radio_section_select_category.dart';

import 'package:provider/provider.dart';

class CreateNoteSetup extends StatelessWidget {
  const CreateNoteSetup({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  const Heading(text: "Criando uma nova anotação"),
                  const SizedBox(height: 64),
                  if (dataProvider.getCategories.isNotEmpty)
                    const RadioSelectCategory(),
                  const Heading(
                    text: "Crie um caderno para essa anotação",
                  ),
                  const SizedBox(height: 16),
                  CreateNewCategorySection(),
                ]),
              )
            ],
          ),
        ));
  }
}
