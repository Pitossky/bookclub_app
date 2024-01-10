import 'package:book_club_app/models/appUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(AppUser user) async {
    String retVal = 'error';

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = 'success';
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<AppUser> getUserInfo(String uid) async {
    AppUser _retVal = AppUser();

    try {
      DocumentSnapshot _docSnap =
          await _firestore.collection('users').doc(uid).get();
      _retVal.uid = uid;
      _retVal.fullName = _docSnap['fullName'];
      _retVal.email = _docSnap['email'];
      _retVal.accountCreated = _docSnap['accountCreated'];
    } catch (e) {
      print(e);
    }
    return _retVal;
  }
}
