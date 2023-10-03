import 'package:flutter/material.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/widgets/index.dart';
import 'package:provider/provider.dart';

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
                              child: Text("Puxa... tão vazio aqui..."));
                        } else {
                          return ListView.builder(
                              itemCount: data.getCategories.length,
                              itemBuilder: ((context, index) {
                                return CategoryRow(
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
        floatingActionButton: const FloatingOptionsButton()
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
