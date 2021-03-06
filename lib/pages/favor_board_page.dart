import 'package:KarmaG11/backend/firebase_real_time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FavorBoard extends StatefulWidget {
  @override
  _FavorBoardState createState() => _FavorBoardState();
}

class _FavorBoardState extends State<FavorBoard> {
  int _selectedIndex;
  @override
  Widget build(BuildContext context) {


    Widget card(String favor, String detalle,int index) {
      return Container(
        child: Card(
          color: (index == _selectedIndex) ? Colors.black : Colors.blue,
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
                title:
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            '$favor',
                            style: TextStyle(
                                color: (index == _selectedIndex)
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),

                subtitle:Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            '$detalle',
                            style: TextStyle(
                                color: (index == _selectedIndex)
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),

                selected: index == _selectedIndex,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    _buildDialog(context, '$favor','$detalle');
                  });
                },
              ),
            ],
          ),
        ),
      );
    }
    void  _search(String s) {

      //return  s.toLowerCase();
      //que busque en el array y devuelva una lista con los matchs y se los asigne a las variables

    }
    final buscador = TextField(
      onChanged: (text) {
        _search(text);
      },
      decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10, left: 10),
          filled: true,
          hintStyle: new TextStyle(color: Colors.blue),
          hintText: "Buscar",
          fillColor: Colors.white38,
          suffixIcon: Icon(Icons.search, color: Colors.blue,)
      ),
    );


    Widget myListView(BuildContext context) {
      // backing data
      final horas = ['Fotocopia', 'LLevar libro', 'Comprar cena', 'Fotocopia'];
      final detalles = ['Código 1233 , 2 hojas', 'Del Cafe a la biblioteca', 'Pizza Peperoni en el Plaza', 'Código 1255 , 1  hoja'];
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: horas.length,
        itemBuilder: (context, index) {
          return card(horas[index], detalles[index],index);
        },
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
                  SizedBox(height: 40),


                  SizedBox(height: 10),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'BOARD OF FAVORS',
                        style: TextStyle(
                            color:Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 40, right: 21, left: 21),
                    child: buscador,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 21, left: 21),
                    child: myListView(context),
                  ),

                ]))));
  }

  Future<void> _buildDialog(BuildContext context, String favor, String detalle) {
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
                    padding: EdgeInsets.fromLTRB(10, 4, 10, 0),
                    child: Text(
                      "Agregado exitosamente",

                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight:FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 4, 10, 0),
                    child: Text(
                      "$favor",

                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight:FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(6, 4 ,6, 0),
                    child:Text(
                      "$detalle",

                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
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
                      Navigator.of(context).pop();
                    })
              ],
            )

          ],
        );
      },
      context: context,
    );
  }
}
