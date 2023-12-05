import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hello_world/apis/pexels_alpha.dart';

import 'package:hello_world/widgets/button.dart';
import 'package:hello_world/widgets/heading.dart';
import 'package:hello_world/widgets/input_text.dart';
import 'package:hello_world/widgets/or_divider.dart';

class NotebookCoverMenu extends StatefulWidget {
  final Function handleSetCover;
  const NotebookCoverMenu({super.key, required this.handleSetCover});

  @override
  State<NotebookCoverMenu> createState() => _NotebookCoverMenuState();
}

class _NotebookCoverMenuState extends State<NotebookCoverMenu> {
  TextEditingController controller = TextEditingController(text: "");
  bool isFetching = false;
  List<dynamic> images = [];

  handleSearch() async {
    if (controller.text.isNotEmpty) {
      setState(() {
        isFetching = true;
      });
      try {
        String query = controller.text;
        final photos = await getSearchImagesAlpha(query);
        setState(() {
          images = photos;
        });
      } finally {
        setState(() {
          isFetching = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (images.isNotEmpty)
                      InkWell(
                          onTap: () {
                            setState(() {
                              images = [];
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Row(children: [
                              Icon(Icons.arrow_back),
                              SizedBox(width: 8),
                              Text("Voltar")
                            ]),
                          )),
                    const Heading(text: "Busca por imagem"),
                    const SizedBox(
                      height: 16,
                    ),
                    InputText(
                        controller: controller,
                        action: TextInputAction.search,
                        hintText: "Ex.: Science Fiction",
                        onEdittingComplete: handleSearch,
                        onChanged: (value) {}),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: isFetching
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black),
                            )
                          : images.isEmpty
                              ? Column(
                                  children: [
                                    const Icon(Icons.language, size: 32),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text(
                                      "Imagens fornecidas pela Pexels API. Use buscas em inglês para melhores resultados.",
                                      textAlign: TextAlign.center,
                                    ),
                                    const OrDivider(),
                                    Button(
                                        text: "BUSCAR NO DISPOSITIVO",
                                        onPressed: () {
                                          // TODO: Search in local files...
                                        }),
                                  ],
                                )
                              : SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    children: [
                                      ...images
                                          .map((image) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 0),
                                              child: InkWell(
                                                onTap: () {
                                                  widget.handleSetCover(image);
                                                  Navigator.pop(context);
                                                },
                                                child: Ink(
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                image)),
                                                  ),
                                                ),
                                              )))
                                          .toList(),
                                    ],
                                  ),
                                ),
                    )
                  ],
                )),
          );
        });
  }
}
