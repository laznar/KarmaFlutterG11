import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
get _getFirebaseChatReference => databaseReference.child("messages");

Future<String> sendChatMsg(String text) async {
  try {
    var firebaseUser = await _auth.currentUser();
    final FirebaseUser user = firebaseUser;
    final uid = user.uid;
    databaseReference.child("messages").push().set({'msg': text, 'user': uid});
  } catch (error) {
    print('ERRORS');
    print(error.message.toString());
    print(error.code.toString());
    return Future.error(error.message.toString());
  }
}
