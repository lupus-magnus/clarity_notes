import 'package:flutter/material.dart';

class CategoryCover extends StatelessWidget {
  final String pathOrUrl;
  const CategoryCover({super.key, required this.pathOrUrl});

  @override
  Widget build(BuildContext context) {
    final isCoverLocal = !pathOrUrl.contains('http');

    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: isCoverLocal
          ? Image.asset(pathOrUrl, fit: BoxFit.cover)
          : Image.network(pathOrUrl, fit: BoxFit.cover),
    );
  }
}
