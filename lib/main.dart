import 'package:flutter/material.dart';
import 'package:project/AlbumPage.dart';
import 'package:project/ArtistPage.dart';
import 'package:project/Homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/artist': (context) => const ArtistPage(),
        '/album': (context) => const AlbumPage()
      }
    );
  }
}