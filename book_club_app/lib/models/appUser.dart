import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? accountCreated;

  AppUser({this.uid, this.email, this.fullName, this.accountCreated});
}
