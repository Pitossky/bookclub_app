import 'package:book_club_app/screens/root/root.dart';
import 'package:book_club_app/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            CurrentUser _currentUser = Provider.of(
              context,
              listen: false,
            );
            String _retString = await _currentUser.signOut();
            if (_retString == 'success') {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => AppRoot(),
                ),
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
