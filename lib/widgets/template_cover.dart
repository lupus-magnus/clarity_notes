import 'package:flutter/material.dart';

class TemplateCover extends StatelessWidget {
  const TemplateCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
                "https://d150u0abw3r906.cloudfront.net/wp-content/uploads/2021/10/image2-2-1024x649.png",
                fit: BoxFit.cover),
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(16),
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
                    padding: EdgeInsets.only(right: 0), // 16),
                    child: Positioned(
                      bottom: 20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )))
          ],
        ));
  }
}


//  Positioned(
//                     right: 0,
//                     top: 100, // Ajuste este valor para metade da altura do Hero
//                     child: CircleAvatar(
//                       radius: 20,
//                       backgroundColor: Colors.red,
//                       child: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                       ),