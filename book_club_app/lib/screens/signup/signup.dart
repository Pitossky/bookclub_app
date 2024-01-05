import 'package:book_club_app/screens/signup/localWidgets/signupForm.dart';
import 'package:flutter/material.dart';

class OurSignUp extends StatelessWidget {
  const OurSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackButton(),
                    ],
                  ),
                  SizedBox(height: 40),
                  OurSignupForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
