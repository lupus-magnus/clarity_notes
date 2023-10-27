import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:hello_world/widgets/input_text.dart';
import 'package:provider/provider.dart';

class CreateNewCategorySection extends StatefulWidget {
  CreateNewCategorySection({super.key});

  final TextEditingController newCategoryTitleController =
      TextEditingController(text: '');

  @override
  State<CreateNewCategorySection> createState() =>
      _CreateNewCategorySectionState();
}

class _CreateNewCategorySectionState extends State<CreateNewCategorySection> {
  bool submitIsDisabled = true;

  handleSubmit(BuildContext context) async {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    String newCategoryValue = widget.newCategoryTitleController.text;
    Category newCategory = await dataProvider.addCategory(newCategoryValue);
    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WriteView(categoryId: newCategory.id),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(
          controller: widget.newCategoryTitleController,
          onChanged: (newValue) {
            setState(() {
              submitIsDisabled = widget.newCategoryTitleController.text == '';
            });
          },
        ),
        const SizedBox(height: 16),
        Button(
          text: "AVANÇAR",
          onPressed: () {
            handleSubmit(context);
          },
          disabled: submitIsDisabled,
        )
      ],
    );
  }
}
