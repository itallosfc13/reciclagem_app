import 'package:flutter/material.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const ReciclaApp());
}

class ReciclaApp extends StatelessWidget {
  const ReciclaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'ReciclaApp',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),

      home: const LoginPage(),
    );
  }
}