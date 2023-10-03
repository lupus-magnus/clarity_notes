import 'package:flutter/material.dart';
import 'package:hello_world/screens/home_view.dart';

class TemplateCover extends StatelessWidget {
  final bool renderBacklink;

  const TemplateCover({super.key, this.renderBacklink = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child:
                      Image.asset('assets/images/desk.jpg', fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 48,
                    width: 48,
                    fit: BoxFit.fitWidth,
                  ),
                )),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: const EdgeInsets.only(right: 16.0), // 16),
                    child: Positioned(
                      bottom: 20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/71194923?v=4"))),
                        // decoration:
                      ),
                    ))),
            if (renderBacklink)
              Positioned(
                  bottom: 0,
                  left: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 28,
                    ),
                  ))
          ],
        ));
  }
}
