import 'package:flutter/material.dart';
import 'package:shoppinglist/screens/grocery_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 20, 67, 143),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 19, 56, 87),
        ),
      ),
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(119, 41, 82, 129))),
      home: const GroceryList(),
    );
  }
}
