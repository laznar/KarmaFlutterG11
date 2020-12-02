import 'package:flutter/foundation.dart';

class Favor {
  final int favorID;
  final String type;
  final String details;
  final String ownerID;
  final int assignedID;

  Favor(
      {@required this.favorID,
      @required this.type,
      @required this.details,
      @required this.ownerID,
      this.assignedID});

  Map<String, dynamic> toMap() {
    return {
      'favorID': favorID,
      'type': type,
      'details': details,
      'ownerID': ownerID,
      'assignedID': assignedID
    };
  }

  factory Favor.fromMap(Map<String, dynamic> map) {
    return Favor(
        favorID: map['favorID'],
        type: map['type'],
        details: map['details'],
        ownerID: map['ownerID']);
  }
}
