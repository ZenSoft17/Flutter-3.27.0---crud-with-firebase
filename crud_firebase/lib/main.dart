import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crud_firebase/pages/home.dart';
import 'package:crud_firebase/pages/add.dart';
import 'package:crud_firebase/pages/edit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          titleLarge:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          bodyMedium:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => const Add(),
        '/edit': (context) => const Edit()
      },
    );
  }
}
