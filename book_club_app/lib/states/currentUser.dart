import 'package:book_club_app/models/appUser.dart';
import 'package:book_club_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  AppUser _currentUser = AppUser();

  AppUser get getCurrentUser => _currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = 'error';

    try {
      User _firebaseUser = await _auth.currentUser!;
      if (_firebaseUser != null) {
        _currentUser = await AppDatabase().getUserInfo(_firebaseUser.uid);
        if (_currentUser != null) {
          retVal = 'success';
        }
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signOut() async {
    String retVal = 'error';

    try {
      await _auth.signOut();
      _currentUser = AppUser();
      retVal = 'success';
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signUpUser(
    String email,
    String password,
    String fullName,
  ) async {
    String retVal = 'error';
    AppUser _user = AppUser();

    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user.uid = _userCredential.user!.uid;
      _user.email = _userCredential.user!.email;
      _user.fullName = fullName;
      String _retString = await AppDatabase().createUser(_user);
      if (_retString == 'success') {
        retVal = 'success';
      }
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = 'error';

    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentUser = await AppDatabase().getUserInfo(_authResult.user!.uid);
      if (_currentUser != null) {
        retVal = 'success';
      }
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }

  Future<String> GoogleLogin() async {
    String retVal = 'error';

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    AppUser _user = AppUser();

    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: _googleAuth.idToken,
        accessToken: _googleAuth.accessToken,
      );
      UserCredential _authResult = await _auth.signInWithCredential(credential);
      if (_authResult.additionalUserInfo!.isNewUser) {
        _user.uid = _authResult.user!.uid;
        _user.email = _authResult.user!.email;
        _user.fullName = _authResult.user!.displayName;
        AppDatabase().createUser(_user);
      }
      _currentUser = await AppDatabase().getUserInfo(_authResult.user!.uid);
      if (_currentUser != null) {
        retVal = 'success';
      }
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }
}
