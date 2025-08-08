// lib/presentation/routes/app_routes.dart
import 'package:app_morty/presentation/views/character_list_page.dart';
import 'package:app_morty/presentation/views/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String characterList = '/characters';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashPage(),
        characterList: (_) => const CharacterListPage(),

      };
}
