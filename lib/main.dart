import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/providers/user_data.dart';
import 'package:hello_world/screens/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserDataProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            fontFamily: "Poppins",
            useMaterial3: true,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black)),
            )),
        home: const HomeView());
  }
}
