import 'package:flutter/material.dart';
//import 'package:my_multi_screen_project/view/dashboard.dart';
import 'package:my_multi_screen_project/view/new_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyNewScreen(),
    );
  }
}
