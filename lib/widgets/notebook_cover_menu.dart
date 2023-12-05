import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hello_world/apis/pexels_alpha.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:hello_world/widgets/heading.dart';
import 'package:hello_world/widgets/input_text.dart';
import 'package:hello_world/widgets/or_divider.dart';
import 'package:uuid/uuid.dart';

class NotebookCoverMenu extends StatefulWidget {
  final Function handleSetCover;
  const NotebookCoverMenu({super.key, required this.handleSetCover});

  @override
  State<NotebookCoverMenu> createState() => _NotebookCoverMenuState();
}

class _NotebookCoverMenuState extends State<NotebookCoverMenu> {
  TextEditingController controller = TextEditingController(text: "");
  bool isFetching = false;
  bool isUploadingImage = false;
  List<dynamic> images = [];

  handleSearch(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      setState(() {
        isFetching = true;
      });
      try {
        String query = controller.text;
        final photos = await getSearchImagesAlpha(query, context);
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

  handlePickImageFromGallery(BuildContext context) async {
    UploadTask? uploadTask;
    // Open file explorer and select image from gallery
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    final file = File(returnedImage.path);

    try {
      // Upload file to Firebase Storage
      setState(() {
        isUploadingImage = true;
      });
      final bucket = FirebaseStorage.instance.ref();
      final bucketImagesDir = bucket.child('images');
      final newFileName = "${const Uuid().v4()}-${returnedImage.name}";
      final newFileRef = bucketImagesDir.child(newFileName);
      uploadTask = newFileRef.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      widget.handleSetCover(url);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showToast(
          "Não foi possível realizar a operação agora.\nPor favor, tente mais tarde.",
          context: context);
    } finally {
      setState(() {
        isUploadingImage = false;
        Navigator.pop(context);
      });
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
                        onEdittingComplete: () {
                          handleSearch(context);
                        },
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
                                      text: isUploadingImage
                                          ? "CARREGANDO..."
                                          : "BUSCAR NO DISPOSITIVO",
                                      disabled: isUploadingImage,
                                      onPressed: () {
                                        handlePickImageFromGallery(context);
                                      },
                                    ),
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
