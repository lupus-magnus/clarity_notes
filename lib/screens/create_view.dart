import 'package:flutter/material.dart';
import 'package:hello_world/screens/create_category_setup.dart';
import 'package:hello_world/screens/create_note_setup.dart';
import 'package:hello_world/widgets/bottom_navbar.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:hello_world/widgets/custom_app_bar.dart';

import 'package:hello_world/widgets/heading.dart';

class CreateOption {
  final String label;
  final String value;

  CreateOption({required this.label, required this.value});
}

class CreateView extends StatefulWidget {
  const CreateView({super.key});

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  String? selectedOption;

  final options = [
    CreateOption(label: "Anotação", value: "note"),
    CreateOption(label: "Caderno", value: "category"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Heading(text: "O quê deseja criar?"),
            const SizedBox(height: 16),
            SizedBox(
                width: double.infinity,
                height: 168,
                child: ListView(
                    children: options
                        .map(
                          (option) => (Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4)),
                                child: RadioListTile(
                                    value: option.value,
                                    activeColor: Colors.black,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value;
                                      });
                                    },
                                    title: Text(option.label)),
                              ))),
                        )
                        .toList())),
            const SizedBox(height: 16),
            Button(
                text: "AVANÇAR",
                disabled: selectedOption == null,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => selectedOption == 'note'
                          ? const CreateNoteSetup()
                          : const CreateCategorySetup(),
                    ),
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
