import 'package:book_club_app/screens/home/home.dart';
import 'package:book_club_app/screens/login/login.dart';
import 'package:book_club_app/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  loggedIn,
  notLoggedIn,
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    CurrentUser _currentUser = Provider.of<CurrentUser>(
      context,
      listen: false,
    );
    String _retString = await _currentUser.onStartUp();
    if (_retString == 'success') {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retWidget = Container();

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retWidget = OurLogin();
        break;
      case AuthStatus.loggedIn:
        retWidget = HomeScreen();
        break;
      default:
    }

    return retWidget;
  }
}
