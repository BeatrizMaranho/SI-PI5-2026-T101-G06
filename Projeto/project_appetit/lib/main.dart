import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
<<<<<<< Updated upstream
=======
import 'package:project_appetit/components/main_screen.dart';
import 'package:project_appetit/screens/login_screen.dart';
import 'package:project_appetit/screens/main_admin_screen.dart';
import 'package:project_appetit/screens/upload_photos_screen.dart';
>>>>>>> Stashed changes

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

<<<<<<< Updated upstream
  runApp(const MyApp());
=======
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
>>>>>>> Stashed changes
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appetit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
<<<<<<< Updated upstream
      home: const MyHomePage(),
=======
      home: const AuthWrapper(),
      routes: {'/upload-photos': (context) => const UploadPhotosScreen()},
>>>>>>> Stashed changes
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return const Scaffold(
      body: Center(
        child: Text(
          'Appetit',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
            letterSpacing: 2.0,
          ),
        ),
      ),
=======
    return FutureBuilder<Map<String, String?>>(
      future: _getAuthData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data;
        final bool loggedIn = data?['isLoggedIn'] == 'true';
        final String? uid = data?['userId'];
        final String? type = data?['userType'];

        if (loggedIn && uid != null) {
          if (type == 'admin') {
            return const MainScreenAdmin();
          }
          return MainScreen(userId: uid);
        }

        return const LoginScreen();
      },
>>>>>>> Stashed changes
    );
  }
}
