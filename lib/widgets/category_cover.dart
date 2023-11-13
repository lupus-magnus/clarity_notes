import 'package:flutter/material.dart';

class CategoryCover extends StatelessWidget {
  const CategoryCover({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
    );
  }
}
