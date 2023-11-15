import 'package:flutter/material.dart';
import 'package:hello_world/utils/format_datetime.dart';

class NotebookCover extends StatelessWidget {
  final String cover;
  final String name;
  final String description;
  final DateTime updatedAt;
  final int totalNotes;

  const NotebookCover({
    super.key,
    required this.cover,
    required this.name,
    required this.description,
    required this.totalNotes,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    image: AssetImage(cover),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(description,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500)),
                  ],
                ),
              )
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
                          label: totalNotes == 0
                              ? 'Sem anotações'
                              : totalNotes == 1
                                  ? "1 anotação"
                                  : "$totalNotes anotações",
                          icon: const Icon(Icons.file_copy_outlined, size: 12)),
                      MetadataRow(
                          label: getFormattedDateTime(updatedAt),
                          icon: const Icon(Icons.calendar_month_outlined,
                              size: 12))
                    ]),
              ))
        ],
      ),
    );
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
          style: const TextStyle(
              fontSize: 10, color: Color.fromRGBO(51, 51, 51, 1)),
        )
      ],
    );
  }
}
