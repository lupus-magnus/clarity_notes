import 'package:flutter/material.dart';

import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/home_view.dart';
import 'package:hello_world/widgets/button.dart';

import 'package:hello_world/widgets/heading.dart';
import 'package:provider/provider.dart';

class SelectPredefinedCategories extends StatefulWidget {
  const SelectPredefinedCategories({super.key});

  @override
  State<SelectPredefinedCategories> createState() =>
      _SelectPredefinedCategoriesState();
}

class _SelectPredefinedCategoriesState
    extends State<SelectPredefinedCategories> {
  List<Map> options = [
    {"name": 'Anotações semanais', 'id': '1', "selected": false},
    {"name": 'Diário', 'id': '2', "selected": false},
    {"name": 'Reviews gastronômicos', 'id': '3', "selected": false}
  ];

  handleSubmit(BuildContext context) async {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);

    List<Map> selectedCategorySuggestions =
        options.where((element) => !!element['selected']).toList();
    for (var selectedSuggestion in selectedCategorySuggestions) {
      String newCategoryValue = selectedSuggestion['name'];
      await dataProvider.addCategory(newCategoryValue);
    }

    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Heading(
          text: "Use cadernos sugeridos",
        ),
        const SizedBox(height: 8),
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
                            child: CheckboxListTile(
                                value: option['selected'],
                                activeColor: Colors.black,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (newValue) {
                                  setState(() {
                                    options = options
                                        .map((elem) => elem['id'] ==
                                                option['id']
                                            ? {...option, "selected": newValue}
                                            : elem)
                                        .toList();
                                  });
                                },
                                title: Text(option["name"])),
                          ))),
                    )
                    .toList())),
        const SizedBox(height: 16),
        Button(
            text: "AVANÇAR",
            disabled: !options.any((element) => element['selected'] == true),
            onPressed: () {
              handleSubmit(context);
            }),
      ],
    );
  }
}
