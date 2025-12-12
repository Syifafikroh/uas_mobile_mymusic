import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home_page.dart';
import 'pages/detail_page.dart';
import 'pages/list_page.dart';
import 'pages/login_page.dart';
import 'pages/favorite_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyMusic App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: false,
      ),

      // ========================
      // CEK SUDAH LOGIN APA BELUM
      // ========================
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(); // loading ringan
          }
          if (!snapshot.hasData) {
            return const LoginPage();
          }

          final prefs = snapshot.data as SharedPreferences;
          final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

          return isLoggedIn ? const HomePage() : const LoginPage();
        },
      ),

      routes: {
        "/home": (_) => const HomePage(),
        "/detail": (_) => const DetailPage(),
        "/list": (_) => const ListPage(),
        "/login": (_) => const LoginPage(),
        "/favorite": (_) => const FavoritePage(),
      },
    );
  }
}
