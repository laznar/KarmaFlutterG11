import 'dart:math';

import 'package:KarmaG11/models/favor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final db = Firestore.instance;
Favor currentFavor;

get _getFirebaseUID async {
  final FirebaseUser user = await _auth.currentUser();
  final uid = user.uid;
  return uid;
}

Future<String> createFavor(favorID, type, details, ownerID) async {
  final FirebaseUser user = await _auth.currentUser();
  final uid = user.uid;
  Random random = new Random();
  int randomNumber = random.nextInt(1000)
  currentFavor = Favor(favorID: randomNumber, type: type, details: details, ownerID: uid);

    await db
      .collection('favors')
      .document(uid)
      .setData(currentFavor.toMap());

  return Future.value("OK");
}
