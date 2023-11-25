import 'package:flutter/material.dart';

import 'package:hello_world/apis/pexels_alpha.dart';
import 'package:hello_world/themes/theme.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:hello_world/widgets/heading.dart';
import 'package:hello_world/widgets/input_text.dart';
import 'package:lottie/lottie.dart';

class PexelsMenu extends StatefulWidget {
  final Function handleSetCover;
  const PexelsMenu({super.key, required this.handleSetCover});

  @override
  State<PexelsMenu> createState() => _PexelsMenuState();
}

class _PexelsMenuState extends State<PexelsMenu> {
  TextEditingController controller = TextEditingController(text: "");
  bool isFetching = false;
  List<dynamic> images = [];
  String? selectedImage;

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
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: themeColors['background'],
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Heading(text: "Busca por imagem"),
                  const SizedBox(
                    height: 16,
                  ),
                  InputText(
                      controller: controller,
                      hintText: "Ex.: Science Fiction",
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 16,
                  ),
                  Button(
                    text: "BUSCAR",
                    icon: const Icon(Icons.search),
                    onPressed: handleSearch,
                    outlined: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: isFetching
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.black),
                          )
                        : images.isEmpty
                            ? Center(
                                child: LottieBuilder.asset(
                                  'assets/animations/search.json',
                                  height: 120,
                                ),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                    children: images
                                        .map((image) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 0),
                                            child: InkWell(
                                              onTap: () => setState(() {
                                                selectedImage = image;
                                              }),
                                              child: Ink(
                                                height: 80,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            image)),
                                                    border: Border.all(
                                                        color: selectedImage ==
                                                                image
                                                            ? Colors.black
                                                            : Colors
                                                                .transparent,
                                                        width: 4)),
                                              ),
                                            )))
                                        .toList()),
                              ),
                  ),
                  Button(
                      text: "PRONTO",
                      onPressed: () {
                        widget.handleSetCover(selectedImage);
                        Navigator.pop(context);
                      })
                ],
              ))),
    );
  }
}
