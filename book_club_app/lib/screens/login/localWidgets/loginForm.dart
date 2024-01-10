import 'package:book_club_app/screens/home/home.dart';
import 'package:book_club_app/screens/signup/signup.dart';
import 'package:book_club_app/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_club_app/states/currentUser.dart';

enum LoginType {
  email,
  google,
}

class OurLoginForm extends StatefulWidget {
  const OurLoginForm({super.key});

  @override
  State<OurLoginForm> createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _loginUser({
    String? email,
    String? password,
    BuildContext? context,
    required LoginType type,
  }) async {
    CurrentUser _currentUser =
        Provider.of<CurrentUser>(context!, listen: false);

    try {
      String _retString = '';

      switch (type) {
        case LoginType.email:
          _retString = await _currentUser.loginUserWithEmail(
            email!,
            password!,
          );
          break;
        case LoginType.google:
          _retString = await _currentUser.GoogleLogin();
          break;
        default:
      }

      if (_retString == 'success') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_retString),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _googleButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      onPressed: () {
        _loginUser(
          context: context,
          type: LoginType.google,
        );
      },
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/google_logo.png"),
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 8,
            ),
            child: Text(
              'Log In',
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: 'Email',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Password',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _loginUser(
                email: _emailController.text,
                password: _passwordController.text,
                context: context,
                type: LoginType.email,
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OurSignUp(),
                ),
              );
            },
            child: const Text(
              "Don't have an account? Sign up!",
            ),
          ),
          _googleButton(),
        ],
      ),
    );
  }
}
