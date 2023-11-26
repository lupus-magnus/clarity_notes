import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/models/category.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/category_view.dart';
import 'package:hello_world/themes/theme.dart';
import 'package:hello_world/utils/format_datetime.dart';
import 'package:provider/provider.dart';

class NotebookCover extends StatelessWidget {
  final Category category;
  final int delayMs;
  const NotebookCover({super.key, required this.category, this.delayMs = 300});

  @override
  Widget build(BuildContext context) {
    return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryView(category: category),
                ),
              );
            },
            child: Container(
              height: 226,
              width: 160,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 3.0,
                    blurRadius: 3.0,
                    offset: Offset(3, 3),
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  )
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: category.cover.contains('http')
                                ? NetworkImage(category.cover)
                                : AssetImage(category.cover) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(category.description,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ))
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MetadataRow(
                                  label: category.notes.isEmpty
                                      ? 'Sem anotações'
                                      : category.notes.length == 1
                                          ? "1 anotação"
                                          : "${category.notes.length} anotações",
                                  icon: const Icon(Icons.file_copy_outlined,
                                      size: 12)),
                              MetadataRow(
                                  label:
                                      getFormattedDateTime(category.updatedAt),
                                  icon: const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 12))
                            ]),
                      )),
                  Positioned(
                      bottom: 16,
                      right: 8,
                      child: InkWell(
                          onTap: () {
                            context
                                .read<UserDataProvider>()
                                .toggleFavoriteCategory(category.id);
                          },
                          child: Icon(
                            category.favorite ? Icons.star : Icons.star_border,
                            color: category.favorite
                                ? themeColors['primary']
                                : themeColors['disabled'],
                          )))
                ],
              ),
            ))
        .animate()
        .fadeIn(delay: delayMs.ms)
        .moveX(begin: 24, end: 0, delay: delayMs.ms)
        .moveY(begin: 24, end: 0, delay: delayMs.ms);
  }
}

class MetadataRow extends StatelessWidget {
  final String label;
  final Widget icon;
  const MetadataRow({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 4,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: themeColors['mutedText']),
        )
      ],
    );
  }
}
