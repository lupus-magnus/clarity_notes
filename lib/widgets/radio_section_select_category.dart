import 'package:flutter/material.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:hello_world/widgets/custom_radio_options.dart';
import 'package:hello_world/widgets/heading.dart';
import 'package:hello_world/widgets/or_divider.dart';
import 'package:provider/provider.dart';

class RadioSelectCategory extends StatefulWidget {
  const RadioSelectCategory({super.key});

  @override
  State<RadioSelectCategory> createState() => _RadioSelectCategoryState();
}

class _RadioSelectCategoryState extends State<RadioSelectCategory> {
  String? categoryId;

  void handleSelectCategory(String newValue) {
    setState(() {
      categoryId = newValue;
    });
  }

  void handleButtonPress() {
    if (categoryId != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WriteView(categoryId: categoryId as String),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    return Column(
      children: [
        const Heading(
          text: "Escolha um caderno",
        ),
        const SizedBox(height: 8),
        CustomRadioOptions(
          options: dataProvider.getCategories
              .map((category) => category.toMap())
              .toList(),
          labelField: "name",
          valueField: 'id',
          groupValue: categoryId ?? '',
          onChange: handleSelectCategory,
        ),
        const SizedBox(height: 16),
        Button(
            text: "AVANÇAR",
            disabled: categoryId == null,
            onPressed: categoryId != null ? handleButtonPress : null),
        const OrDivider(),
      ],
    );
  }
}
