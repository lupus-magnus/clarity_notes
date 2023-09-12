import 'package:flutter/material.dart';
import 'package:hello_world/providers/menu_provider.dart';
import 'package:hello_world/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => MenuProvider(),
        child: const HomeView(),
      ),
    );
  }
}
