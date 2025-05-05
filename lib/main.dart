import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_api/providers/TodoProvider.dart';
import 'package:todo_with_api/screens/screen_1.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MyApp(),
    ),
  );
  print("The app has started");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      debugShowCheckedModeBanner: false,
      home: Screen1(),
    );
  }
}
