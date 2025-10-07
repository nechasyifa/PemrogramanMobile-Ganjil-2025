import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout: Necha Syifa Syafitri - 2341720167',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter layout demo')),
        body: const Center(child: Text('Hello World')),
      ),
    );
  }
}
