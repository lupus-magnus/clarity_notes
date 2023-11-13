import 'package:flutter/material.dart';

class NotebookCover extends StatelessWidget {
  const NotebookCover({super.key});

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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/textures/1.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Column(
                  children: [
                    Text("Anotações Semanais",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Rascunhos e lembretes para salvar no diário.",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500)),
                  ],
                ),
              )
            ],
          ),
          const Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MetadataRow(
                          label: "7 anotações",
                          icon: Icon(Icons.file_copy_outlined, size: 12)),
                      MetadataRow(
                          label: "23 Set 2023 | 16:20",
                          icon: Icon(Icons.calendar_month_outlined, size: 12))
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
