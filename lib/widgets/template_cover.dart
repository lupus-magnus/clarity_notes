import 'package:flutter/material.dart';
import 'package:hello_world/screens/home_view.dart';

class TemplateCover extends StatelessWidget {
  final bool renderBacklink;

  const TemplateCover({super.key, this.renderBacklink = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: const EdgeInsets.only(right: 16.0), // 16),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/app/icon.png"))),
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
