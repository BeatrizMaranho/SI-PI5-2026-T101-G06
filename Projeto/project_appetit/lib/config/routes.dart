import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/people_screen.dart';
import '../widgets/main_layout.dart';
import '../screens/upload_photos_screen.dart';
import '../screens/documents_screen.dart';
import '../screens/profile_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String people = '/people';
  static const String uploadPhotos = '/upload-photos';
  static const String documents = '/documents';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const MainLayout(),
      '/home': (context) => const HomeScreen(),
      '/people': (context) => const PeopleScreen(),
      '/upload-photos': (context) => const UploadPhotosScreen(),
      '/documents': (context) => const DocumentsScreen(),
      '/profile': (context) => const ProfileScreen(),
    };
  }
}
