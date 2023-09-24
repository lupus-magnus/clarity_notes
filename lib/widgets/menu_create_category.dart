import 'package:flutter/material.dart';
import 'package:hello_world/providers/menu.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:provider/provider.dart';

class MenuCreateCategory extends StatelessWidget {
  const MenuCreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    TextEditingController controller = TextEditingController();

    void handleCreateCategory() {
      UserDataProvider dataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      String newCategoryValue = controller.text;
      bool categoryIsValid = newCategoryValue.isNotEmpty;
      if (categoryIsValid) {
        dataProvider.addCategory(newCategoryValue);
      }
      Navigator.pop(context);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: controller,
            cursorColor: Colors.white,
            autofocus: true,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
              hintText: "Insira um nome para a categoria...",
              prefixIcon:
                  const Icon(Icons.add_circle_outline, color: Colors.white),
              suffixIcon: IconButton(
                onPressed: handleCreateCategory,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(24, 8, 16, 8),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(8, 8, 4, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(128, 0, 0, 0),
                  ),
                  child: InkWell(
                      onTap: () {
                        menuProvider.handleChangeMenu(Menu.main);
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(
                              Icons.cancel_outlined,
                              color: Color.fromARGB(255, 220, 53, 69),
                              size: 48,
                            ),
                          ),
                          Text(
                            "Cancelar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(255, 220, 53, 69),
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(128, 0, 0, 0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: InkWell(
                        onTap: handleCreateCategory,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                            Text(
                              "Prosseguir",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
