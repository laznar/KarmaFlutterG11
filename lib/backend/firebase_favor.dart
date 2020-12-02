import 'dart:math';

import 'package:KarmaG11/models/favor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final db = Firestore.instance;
Favor currentFavor;

get _getFirebaseUID async {
  final FirebaseUser user = await _auth.currentUser();
  final uid = user.uid;
  return uid;
}
