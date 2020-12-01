

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
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blue,
              width: 5.0,
            ),
            borderRadius: BorderRadius.circular(26.0),
          ),
          backgroundColor: Colors.blue,
          content: SingleChildScrollView(
              child:Column(

                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(

                      obscureText: false,
                      keyboardType: TextInputType.text,
                      controller: this.controllerTipo,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.black
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Type",
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
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
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Colors.black
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),

                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelText: "Details",
                        hintText: "Address, info ",
                      ),
                    ),
                  ),
                ],
              )),

          actions: <Widget>[
            Column(
              children: [
                IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.check_circle, size: 40,),
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

              ],
            )

          ],
        );
      },
      context: context,
    );
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
