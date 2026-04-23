import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de "Debug"
      title: 'Appetit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange), // Laranja lembra comida!
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Appetit',
          style: TextStyle(
            fontSize: 48,           // Tamanho grande para o tablet
            fontWeight: FontWeight.bold,
            color: Colors.orange,   // Cor principal do seu PI
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}