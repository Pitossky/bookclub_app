import 'package:book_club_app/screens/login/localWidgets/loginForm.dart';
import 'package:flutter/material.dart';

class OurLogin extends StatelessWidget {
  const OurLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Padding(padding: EdgeInsets.all(40),
                child: Image.asset('assets/logo.png'),
                ),
                SizedBox(height: 20),
                OurLoginForm()
              ],
            ),
            ),
      ],
      ),
    );
  }
}