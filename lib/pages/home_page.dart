import 'package:KarmaG11/backend/firebase_auth.dart';
import 'package:KarmaG11/models/karma_model.dart';
import 'package:KarmaG11/providers/authProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final int karmapoints = 5;
  final String user = "user";
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Spacer(),
          Text(
            "Usuario: " + '$user',
            style: TextStyle(
                color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text("Puntos de karma " + '$karmapoints',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          Text("Últimos movimientos"),
          Spacer()
        ]));
    //return _buildBody(context);
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final karma = Karma.fromSnapshot(data);

    return Padding(
      key: ValueKey(karma.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(karma.name),
          trailing: Text(karma.votes.toString()),
          onTap: () => karma.reference.updateData({'votes': karma.votes + 1}),
        ),
      ),
    );
  }
}
