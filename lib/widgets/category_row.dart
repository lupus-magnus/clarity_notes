import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/write_view.dart';
import 'package:hello_world/widgets/note_thumbnail.dart';
import 'package:provider/provider.dart';

class CategoryRow extends StatelessWidget {
  final Category data;
  final double marginTop;
  final int animDelay;
  const CategoryRow(
      {super.key,
      required this.data,
      this.marginTop = 0,
      required this.animDelay});

  @override
  Widget build(BuildContext context) {
    UserDataProvider dataProvider =
        Provider.of<UserDataProvider>(context, listen: false);

    return Padding(
            padding: EdgeInsets.only(top: marginTop),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      data.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700),
                    )),
                    TextButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Tem certeza dessa operação?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Ao deletar uma categoria, você perderá todas as anotações dela.',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    dataProvider.removeCategory(data.id);
                                  },
                                  child: const Text('Excluir categoria'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.edit_note,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 16.0),
                    child: SizedBox(
                      height: 128,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => WriteView(
                                        categoryId: data.id,
                                      ),
                                    ),
                                  );
                                },
                                child: Material(
                                  color: Colors
                                      .white, // const Color.fromARGB(255, 51, 51, 51),
                                  borderRadius: BorderRadius.circular(16),
                                  child: Ink(
                                    width: 128,
                                    height: 128,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 51, 51, 51),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: const Center(
                                        child: Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      size: 48,
                                    )),
                                  ),
                                ),
                              )),
                          ...data.notes
                              .map((note) => NoteThumbnail(
                                    note: note,
                                    categoryId: data.id,
                                    animDelay: data.notes.indexOf(note) * 300,
                                  ))
                              .toList()
                        ],
                      ),
                    )),
              ],
            ))
        .animate()
        .moveX(
            begin: 8,
            end: 0,
            delay: Duration(milliseconds: 600 + animDelay),
            duration: const Duration(milliseconds: 300))
        .fadeIn();
  }
}
