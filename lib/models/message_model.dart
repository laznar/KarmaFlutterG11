import 'package:firebase_database/firebase_database.dart';

class Message {
  String key;
  String msg;
  String user;

  Message(this.msg, this.user);

  Message.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        msg = snapshot.value["msg"],
        user = snapshot.value["user"];

  toJson() {
    return {
      "msg": msg,
      "user": user,
    };
  }
}
