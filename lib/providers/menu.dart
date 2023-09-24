import 'package:flutter/material.dart';
import 'package:hello_world/widgets/menu_create_category.dart';
import 'package:hello_world/widgets/menu_home.dart';

class MenuProvider extends ChangeNotifier {
  Menu _currentMenu = Menu.main;

  void handleChangeMenu(Menu newMenuChoice) {
    _currentMenu = newMenuChoice;
    notifyListeners();
  }

  Map<Menu, Widget> menus = {
    Menu.main: Builder(
      builder: (BuildContext context) {
        return const MenuHome();
      },
    ),
    Menu.createCategory: Builder(
      builder: (BuildContext context) {
        return const MenuCreateCategory();
      },
    ),
  };

  Widget getCurrentMenu() {
    return menus[_currentMenu] as Widget;
  }
}

enum Menu { main, createCategory }
