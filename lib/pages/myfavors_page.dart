import 'package:KarmaG11/backend/firebase_real_time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:KarmaG11/backend/firebase_favor.dart';

class MyFavors extends StatefulWidget {
  @override
  _MyFavorsState createState() => _MyFavorsState();
}

class _MyFavorsState extends State<MyFavors> {
  final _formKey = GlobalKey<FormState>();
  final controllerTipo = TextEditingController();
  final controllerEspecificaciones = TextEditingController();

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
              child: Column(
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
                      borderSide: BorderSide(color: Colors.black),
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
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Photocopy, Delivery food...",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: this.controllerEspecificaciones,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
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
                    icon: Icon(
                      Icons.check_circle,
                      size: 40,
                    ),
                    onPressed: () {
                      if (this.controllerEspecificaciones.text != "" &&
                          this.controllerTipo.text != "") {
                        Navigator.of(context).pop();
                        createFavor(this.controllerTipo.text,
                            this.controllerEspecificaciones.text);
                      } else {
                        new AlertDialog(
                          title: Text(
                            "Favor",
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
                                  _addFavor();
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

  Widget card(String favor, String estado, int index) {
    return Container(
      child: Card(
        color: Colors.blue,
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blue,
            width: 5.0,
          ),
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(top: 2),
              title: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  '$favor',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  '$estado',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget myListView(BuildContext context) {
    // backing data
    final misfavores = ['fotocopia', 'comprar cena'];
    final estados = ['en curso', 'finalizado'];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: misfavores.length,
      itemBuilder: (context, index) {
        return card(misfavores[index], estados[index], index);
      },
    );
  }

  void _addFavor() {}
  _onEntryAdded(Event event) {
    print("Somethig was added");
  }

  _onEntryChanged(Event event) {
    print("Somethig changed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Text(
                'MY FAVORS',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(21, 20, 21, 0),
              child: FlatButton(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                child: Text(
                  'Add',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  _showFavor();
                },
              )),
          Container(
            margin: EdgeInsets.only(top: 20, right: 21, left: 21),
            child: myListView(context),
          ),
        ]))));
  }
}
