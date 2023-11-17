import 'package:flutter/material.dart';

class CategoryCover extends StatelessWidget {
  final String pathOrUrl;
  const CategoryCover({super.key, required this.pathOrUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(pathOrUrl, fit: BoxFit.cover),
    );
  }
}
