import 'dart:math';

import 'package:KarmaG11/models/favor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final db = Firestore.instance;
Favor currentFavor;
String karma;

get _getFirebaseUID async {
  final FirebaseUser user = await _auth.currentUser();
  final uid = user.uid;
  return uid;
}

void createFavor(type, details) async {
  final FirebaseUser user = await _auth.currentUser();
  final uid = user.uid;
  final String state = "iniciado";
  Random random = new Random();
  int randomNumber = random.nextInt(1000);
  currentFavor = Favor(
      favorID: randomNumber,
      type: type,
      details: details,
      state: state,
      ownerID: uid);

  await db.collection('favors').document(uid).setData(currentFavor.toMap());
  dynamic newkarma;
  await db
      .collection('users')
      .document(uid)
      .get()
      .then<dynamic>((snapshot) async {
    newkarma = snapshot.data['karma'] - 2;
  });

  await db.collection('users').document(uid).updateData({'karma': newkarma});
}
