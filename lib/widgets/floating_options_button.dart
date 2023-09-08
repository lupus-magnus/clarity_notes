import 'package:flutter/material.dart';
import 'package:hello_world/views/note_view.dart';

class FloatingOptionsButton extends StatefulWidget {
  const FloatingOptionsButton({super.key});

  @override
  State<FloatingOptionsButton> createState() => _FloatingOptionsButtonState();
}

class _FloatingOptionsButtonState extends State<FloatingOptionsButton> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            isExpanded = !isExpanded;
            if (isExpanded) {
              showBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: 240,
                        child: Column(
                          children: [
                            Container(
                                height: 8, color: Color.fromARGB(128, 0, 0, 0)),
                            Expanded(
                                child: Container(
                                    color: Color.fromARGB(255, 51, 51, 51),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(8, 8, 4, 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: const Color.fromARGB(
                                                  128, 0, 0, 0),
                                            ),
                                            child: InkWell(
                                                onTap: () {
                                                  print(
                                                      "Clicou em criar categoria!");
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      child: Icon(
                                                        Icons
                                                            .folder_copy_outlined,
                                                        color: Colors.white,
                                                        size: 48,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Criar\nCategoria",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(4, 8, 8, 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: const Color.fromARGB(
                                                  128, 0, 0, 0),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const NoteView(),
                                                  ),
                                                );
                                              },
                                              child: const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(16),
                                                    child: Icon(
                                                      Icons
                                                          .playlist_add_rounded,
                                                      color: Colors.white,
                                                      size: 48,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Criar\nAnotação",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )))
                          ],
                        ));
                  });
            } else {
              Navigator.pop(context);
            }
          });
        },
        child: isExpanded
            ? const Icon(
                Icons.remove,
                size: 40,
              )
            : Icon(
                Icons.add,
                size: 40,
              ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: CircleBorder(eccentricity: 0.0));
  }
}
