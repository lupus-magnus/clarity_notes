import 'package:flutter/material.dart';
import 'package:hello_world/widgets/index.dart';

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
                  child: ListView(
                    children: const [
                      CategoryRow(name: "Ideias de apps", marginTop: 0),
                      CategoryRow(name: "Minhas músicas"),
                      CategoryRow(name: "Anotações da semana"),
                      SizedBox(height: 64)
                    ],
                  )),
            ),
          )
        ],
      ),
      floatingActionButton: const FloatingOptionsButton(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
