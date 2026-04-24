import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  DevicePreview(
    enabled: true,
    builder: (context) => MyApp(), 
  ),
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
      debugShowCheckedModeBanner: false, // Remove a faixa de "Debug"
=======
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
>>>>>>> Stashed changes
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