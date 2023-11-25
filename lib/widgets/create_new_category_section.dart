import 'package:flutter/material.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/home_view.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:hello_world/widgets/input_text.dart';
import 'package:hello_world/widgets/notebook_more_options_menu.dart';
import 'package:provider/provider.dart';

class CreateNewCategorySection extends StatefulWidget {
  final bool redirectToWriteScreen;
  CreateNewCategorySection({super.key, this.redirectToWriteScreen = true});

  final TextEditingController newCategoryTitleController =
      TextEditingController(text: '');

  final TextEditingController newCategoryDescriptionController =
      TextEditingController(text: '');

  @override
  State<CreateNewCategorySection> createState() =>
      _CreateNewCategorySectionState();
}

class _CreateNewCategorySectionState extends State<CreateNewCategorySection> {
  bool submitIsDisabled = true;
  String? categoryCover;

  handleUpdateCover(String newCover) {
    setState(() {
      categoryCover = newCover;
    });
  }

  handleSubmit(BuildContext context) async {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    String newCategoryValue = widget.newCategoryTitleController.text;
    bool isDescriptionFilled =
        widget.newCategoryDescriptionController.text.isNotEmpty;
    Category newCategory = await dataProvider.addCategory(
      newCategoryValue,
      description: isDescriptionFilled
          ? widget.newCategoryDescriptionController.text
          : null,
      cover: categoryCover,
    );
    if (context.mounted && widget.redirectToWriteScreen) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WriteView(category: newCategory),
        ),
      );
    } else if (context.mounted && !widget.redirectToWriteScreen) {
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
        InputText(
          controller: widget.newCategoryTitleController,
          onChanged: (newValue) {
            setState(() {
              submitIsDisabled = widget.newCategoryTitleController.text == '';
            });
          },
        ),
        const SizedBox(height: 16),
        NotebookMoreOptionsMenu(
          controller: widget.newCategoryDescriptionController,
          setCurrentCover: handleUpdateCover,
          currentSelectedCover: categoryCover,
        ),
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
