import 'package:flutter/material.dart';
import 'package:meeting_app/app/core/theme/color_schemes.g.dart';
import 'package:meeting_app/app/screens/sign_in/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAoYRrZGk2tIa210dANNE13Pp7rYxXhqc8",
      authDomain: "litdx-intern-meeting.firebaseapp.com",
      projectId: "litdx-intern-meeting",
      storageBucket: "litdx-intern-meeting.appspot.com",
      messagingSenderId: "69185337767",
      appId: "1:69185337767:web:235dcca07385ce3e3c1e82",
      measurementId: "G-BVC27VSJWB",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meeting Management App',
      theme: ThemeData.from(colorScheme: darkColorScheme, useMaterial3: true),
      home: const SignInPage(),
    );
  }
}
