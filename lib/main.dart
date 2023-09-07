import 'package:flutter/material.dart';

// Importing widgets
import 'package:hello_world/widgets/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Column(
            children: <Widget>[
              TemplateCover(),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: ListView(
                        children: [
                          CategoryRow(name: "Ideias de apps"),
                          CategoryRow(name: "Minhas músicas"),
                          CategoryRow(name: "Anotações da semana"),
                        ],
                      )),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingOptionsButton(),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
