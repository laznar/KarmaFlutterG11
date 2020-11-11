

import 'package:KarmaG11/backend/firebase_real_time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controllerTipo = TextEditingController();
  final controllerEspecificaciones= TextEditingController();
  void _sendMsg() {
    sendChatMsg("My Text");
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    databaseReference.child("messages").onChildChanged.listen(_onEntryChanged);
    databaseReference.child("messages").onChildAdded.listen(_onEntryAdded);
  }

  void _showFavor() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("New Favor",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
              content: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        controller: this.controllerTipo,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Type",
                          hintText: "Photocopy, Delivery food...",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        controller:this.controllerEspecificaciones,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Details",
                          hintText: "Address, info ",
                        ),
                      ),
                    ),


                  ],
                ),
              ),

              actions: <Widget>[
                RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: () {
                      if(this.controllerEspecificaciones.text!="" && this.controllerTipo.text!=""){
                        Navigator.of(context).pop();
                        // metodo que agregar el favor
                      }else{
                        new AlertDialog(
                          title: Text("Favor",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          ),
                          content: Text("Information is missing"),
                          actions: <Widget>[
                            RaisedButton(
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      }
                    })
              ]);
        });
  }

  void _addFavor(){

  }
  _onEntryAdded(Event event) {
    print("Somethig was added");
  }

  _onEntryChanged(Event event) {
    print("Somethig changed");
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
        Container(
          margin: EdgeInsets.fromLTRB(300, 450, 10, 10),
          child:FloatingActionButton(
          
          tooltip: 'Add favor',
          child: Icon(Icons.add),
          onPressed: () {
            _showFavor();
          },
        ),
       )
    );
  }
}
