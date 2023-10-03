import 'package:flutter/material.dart';
import 'package:hello_world/providers/menu.dart';
import 'package:hello_world/screens/note_view.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:provider/provider.dart';

class MenuHome extends StatelessWidget {
  const MenuHome({super.key});

  @override
  Widget build(BuildContext context) {
    late MenuProvider menuProvider = context.read<MenuProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 4, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(128, 0, 0, 0),
            ),
            child: InkWell(
                onTap: () {
                  menuProvider.handleChangeMenu(Menu.createCategory);
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.folder_copy_outlined,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    Text(
                      "Criar\nCategoria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
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
            child: InkWell(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const WriteView(),
                //   ),
                // );
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.playlist_add_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  Text(
                    "Criar\nAnotação",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
