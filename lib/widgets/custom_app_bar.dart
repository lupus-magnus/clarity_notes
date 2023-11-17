import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      title: Image.asset('assets/images/brand_black_long.png', height: 32),
    );
  }
}
