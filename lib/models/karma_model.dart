import 'package:cloud_firestore/cloud_firestore.dart';

class Karma {
  final String name;
  final int votes;
  final DocumentReference reference;

  Karma.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Karma.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Karma<$name:$votes>";
}
