import 'package:finalprojet/intro_screen_page.dart';
import 'package:finalprojet/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'vaccin.dart';
import 'formAnimal.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'notif.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: 'B3902D52-8D04-4CB8-AE52-8A043F3A6763');
  NotificationService().initializeNotification();
  NotificationService().showNotification(1, 'Rappel Vaccination !',
      'Ne pas oublier de faire le vaccin  pour votre animal');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreenPage(),
    );
  }
}
