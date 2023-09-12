import 'package:flutter/material.dart';
import 'package:hello_world/providers/menu_provider.dart';
import 'package:hello_world/views/note_view.dart';
import 'package:provider/provider.dart';

class MenuCreateCategory extends StatelessWidget {
  const MenuCreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            cursorColor: Colors.white,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              filled: true, //<-- SEE HERE
              fillColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),

              hintStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
              hintText: "Insira um nome para a categoria...",
              prefixIcon: Icon(Icons.add_circle_outline, color: Colors.white),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),

              contentPadding: EdgeInsets.fromLTRB(24, 8, 16, 8),
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
                      child: Column(
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
                  margin: EdgeInsets.fromLTRB(4, 8, 8, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(128, 0, 0, 0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NoteView(),
                        ),
                      );
                    },
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
                              color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
