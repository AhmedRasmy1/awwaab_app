import 'package:flutter/material.dart';

void main() {
  runApp(const Awwaab());
}

class Awwaab extends StatelessWidget {
  const Awwaab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Awwaab App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Awwaab Home Page')),
      body: const Center(child: Text('Welcome to Awwaab!')),
    );
  }
}
