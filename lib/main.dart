import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/AlbumPage.dart';
import 'package:project/ArtistPage.dart';
import 'package:project/Homepage.dart';
import 'package:project/firebase_options.dart';
import 'package:project/provider/playing_track.dart';
import 'package:project/signin.dart';
import 'package:project/signup.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => PlayingTrack(),
          )
        ],
      child: const MyApp(),
    )
  );
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
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const Signin(),
        '/signup': (context) => const Signup(),
        '/homepage': (context) => const HomePage(),
        '/artist': (context) => const ArtistPage(),
        '/album': (context) => const AlbumPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}