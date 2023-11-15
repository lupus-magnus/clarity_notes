import 'package:flutter/material.dart';
import 'package:hello_world/screens/home_view.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  handleNavigate(int value, BuildContext context) {
    if (value == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 3.0,
            blurRadius: 3.0,
            color: Color.fromRGBO(0, 0, 0, 0.15),
          )
        ],
      ),
      child: BottomNavigationBar(
          selectedItemColor: Colors.black,
          onTap: (value) => handleNavigate(value, context),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Início"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.palette_outlined), label: "Temas"),
            // BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Rotinas"),
            BottomNavigationBarItem(
                icon: Icon(Icons.maps_ugc_rounded), label: "Criar"),
          ]),
    );
  }
}
