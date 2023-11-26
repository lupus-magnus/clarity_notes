import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/themes/theme.dart';
import 'package:hello_world/widgets/heading.dart';
import 'package:hello_world/widgets/input_text.dart';
import 'package:hello_world/widgets/pexels_menu.dart';

class NotebookMoreOptionsMenu extends StatefulWidget {
  final TextEditingController controller;
  final String? currentSelectedCover;
  final Function(String newCover) setCurrentCover;
  const NotebookMoreOptionsMenu({
    super.key,
    required this.controller,
    this.currentSelectedCover,
    required this.setCurrentCover,
  });

  @override
  State<NotebookMoreOptionsMenu> createState() =>
      _NotebookMoreOptionsMenuState();
}

class _NotebookMoreOptionsMenuState extends State<NotebookMoreOptionsMenu> {
  bool showMoreOptions = false;

  void handleSetCover(String newCover) {
    setState(() {
      widget.setCurrentCover(newCover);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Mais opções"),
      children: [
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => PexelsMenu(
                                      handleSetCover: handleSetCover,
                                    ));
                          },
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
                          )),
                    ],
                  ),
                  widget.currentSelectedCover == null
                      ? Container(
                          width: 80,
                          height: 80,
                          color: Colors.white,
                          child: const Center(
                              child: Text(
                            "?",
                            style: TextStyle(fontSize: 32),
                          )),
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  widget.currentSelectedCover!.contains('https')
                                      ? CachedNetworkImageProvider(
                                          widget.currentSelectedCover!)
                                      : AssetImage(widget.currentSelectedCover!)
                                          as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                            ),
                          ),
                        )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: const [
                      WidgetSpan(
                        child: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.info_outline_rounded, size: 14)),
                      ),
                      TextSpan(
                        text:
                            "Banco de imagens fornecido por Pexels. Todos os direitos reservados. Use termos em inglês.",
                      ),
                    ],
                    style: TextStyle(color: themeColors['mutedText']),
                  )),
            )
          ],
        )
      ],
    );
  }
}
