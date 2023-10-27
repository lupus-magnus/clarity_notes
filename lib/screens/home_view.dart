import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/widgets/choose_note_category_dialog.dart';
import 'package:hello_world/widgets/create_category_dialog.dart';
import 'package:hello_world/widgets/home_view_options.dart';
import 'package:hello_world/widgets/index.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: true);

    if (dataProvider.getCategories.isEmpty) {
      return Scaffold(
          body: const Column(
            children: [TemplateCover(), EmptyHomeView()],
          ),
          floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              overlayColor: Colors.black,
              overlayOpacity: 0.4,
              children: [
                SpeedDialChild(
                    child: const Icon(Icons.folder_copy_outlined),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              const CreateCategoryDialog(),
                        ),
                    label: "Criar uma categoria"),
                SpeedDialChild(
                    child: const Icon(Icons.edit_document),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              const ChooseNoteCategoryDialog(),
                        ),
                    label: "Criar uma nota")
              ]));
    }
    return Scaffold(
        body: Column(
          children: <Widget>[
            const TemplateCover(),
            const HomeViewOptions(),
            const Padding(
                padding: EdgeInsets.fromLTRB(80, 16, 80, 0), child: Divider()),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Consumer<UserDataProvider>(
                      builder: (BuildContext context, UserDataProvider data,
                          Widget? widget) {
                        return ListView.builder(
                            itemCount: data.getCategories.length,
                            itemBuilder: ((context, index) {
                              return CategoryRow(
                                animDelay: 600 * index,
                                data: data.getCategories[index],
                                marginTop: index == 0 ? 0 : 32,
                              );
                            }));
                      },
                    )),
              ),
            )
          ],
        ),
        floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            overlayColor: Colors.black,
            overlayOpacity: 0.4,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.folder_copy_outlined),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            const CreateCategoryDialog(),
                      ),
                  label: "Criar uma categoria"),
              SpeedDialChild(
                  child: const Icon(Icons.edit_document),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            const ChooseNoteCategoryDialog(),
                      ),
                  label: "Criar uma nota")
            ]));
  }
}

class EmptyHomeView extends StatelessWidget {
  const EmptyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeViewOptions(),
        const Padding(
            padding: EdgeInsets.fromLTRB(80, 16, 80, 0), child: Divider()),
        const SizedBox(
          height: 64,
        ),
        Lottie.asset("assets/animations/empty.json", fit: BoxFit.cover),
        const Text(
          "Poxa... tão vazio...",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(
              "Experimente criar algumas categorias para organizar os seus pensamentos!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
