import 'dart:io';
import 'package:book_club_app/screens/login/login.dart';
import 'package:book_club_app/states/currentUser.dart';
import 'package:book_club_app/utils/ourTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyCiKqjA_Ri4Tclecbf-UDTGU8iHzERhhdU',
            appId: '1:796235357805:android:47a5146e725c5106336964',
            messagingSenderId: '796235357805',
            projectId: 'bookclub-71234',
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: OurTheme().buildTheme(),
        home: OurLogin(),
      ),
    );
  }
}
