import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qurban/admin.dart';
import 'package:qurban/client.dart';
import 'package:qurban/landing.dart';
import 'package:qurban/Custom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with FirebaseOptions for the web platform
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_PROJECT_ID.appspot.com",
      messagingSenderId: "YOUR_SENDER_ID",
      appId: "YOUR_APP_ID",
    ),
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'landing',
    routes: {
      'landing': (context) => const LoginPage(),
      'admin': (context) => const AdminPage(),
      'client': (context) => const ClientPage(),
      'Custom': (context) => const CustomPage(),
    },
  ));
}

