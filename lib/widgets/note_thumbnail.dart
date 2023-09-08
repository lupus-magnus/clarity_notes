import 'package:flutter/material.dart';

class NoteThumbnail extends StatelessWidget {
  const NoteThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
          width: 128,
          height: 128,
          padding: EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color.fromARGB(255, 51, 51, 51),
          ),
          child: Column(
            children: [
              Text(
                "7 de setembro de 2023",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "Lorem ipsum bla bla bla bla bla",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )),
    );
  }
}
