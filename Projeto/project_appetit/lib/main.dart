import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:project_appetit/components/main_screen.dart';
import 'package:project_appetit/screens/login_screen.dart';
import 'package:project_appetit/screens/main_admin_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final String? userType = prefs.getString('userType');

  Widget telaInicial;

  if (isLoggedIn) {
    if (userType == 'admin') {
      telaInicial = const MainScreenAdmin();
    } else {
      telaInicial = const MainScreen();
    }
  } else {
    telaInicial = const LoginScreen();
  }

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(telaInicial: telaInicial),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.telaInicial});

  final Widget telaInicial;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Appetit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: telaInicial,
    );
  }
}
