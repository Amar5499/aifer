import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/home_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper App',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: HomeView(),
    );
  }

  // Light Theme
  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.yellow,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellowAccent,
          titleTextStyle: TextStyle(color: Colors.black)),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
    );
  }

  // Dark Theme
  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.yellowAccent)),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.blueGrey),
    );
  }
}
