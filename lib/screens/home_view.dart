import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/widgets/choose_note_category_dialog.dart';
import 'package:hello_world/widgets/create_category_dialog.dart';
import 'package:hello_world/widgets/index.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            const TemplateCover(),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Consumer<UserDataProvider>(
                      builder: (BuildContext context, UserDataProvider data,
                          Widget? widget) {
                        if (data.getCategories.isEmpty) {
                          return Center(
                              child: Column(children: [
                            Lottie.asset("assets/animations/empty.json",
                                fit: BoxFit.cover),
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "Poxa... tão vazio...",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Text(
                                "Experimente criar algumas categorias para organizar os seus pensamentos!",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16))
                          ]));
                          //
                          // Center(
                          //     child: Column(
                          //   children: [
                          //     Lottie.network(
                          //         "https://lottie.host/ec5bf3aa-f536-4a5f-9e28-de869e2cd841/yis8hBBzRl.json"),
                          //     const Text("Puxa... tão vazio aqui...")
                          //   ],
                          // ));
                        } else {
                          return ListView.builder(
                              itemCount: data.getCategories.length,
                              itemBuilder: ((context, index) {
                                return CategoryRow(
                                  animDelay: 600 * index,
                                  data: data.getCategories[index],
                                  marginTop: index == 0 ? 0 : 64,
                                );
                              }));
                        }
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
            ])
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
