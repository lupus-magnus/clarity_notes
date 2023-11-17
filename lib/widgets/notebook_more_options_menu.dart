import 'package:flutter/material.dart';
import 'package:hello_world/widgets/heading.dart';
import 'package:hello_world/widgets/input_text.dart';

class NotebookMoreOptionsMenu extends StatefulWidget {
  final TextEditingController controller;
  const NotebookMoreOptionsMenu({super.key, required this.controller});

  @override
  State<NotebookMoreOptionsMenu> createState() =>
      _NotebookMoreOptionsMenuState();
}

class _NotebookMoreOptionsMenuState extends State<NotebookMoreOptionsMenu> {
  bool showMoreOptions = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Mais opções"),
      children: [
        const SizedBox(height: 24),
        Column(
          children: [
            const Heading(
              text: "Descrição do caderno (opcional)",
            ),
            const SizedBox(height: 16),
            InputText(
                controller: widget.controller,
                hintText: "Ex.: Mais um caderno de anotações.",
                onChanged: (value) {}),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Capa do caderno (opcional)",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_search),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Selecionar",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ))
                    ],
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.white,
                    child: const Center(
                        child: Text(
                      "?",
                      style: TextStyle(fontSize: 32),
                    )),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
