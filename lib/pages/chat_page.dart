import 'package:KarmaG11/backend/firebase_real_time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controllerCantidad = TextEditingController();
  final controllerObjeto = TextEditingController();
  final controllerCodigo = TextEditingController();
  final controllerDetalle = TextEditingController();
  int selectedRadio;
  final int karmapoints = 5;
  final String favorstate = "iniciado";
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Solicitar Favores",
          style: TextStyle(
              color: Colors.blue[900],
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        Text("Karmas disponibles " + '$karmapoints.toString()',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 15,
            )),
        Text("Estado del favor " + '$favorstate',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 15,
            )),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: const Text("Sacar fotocopias"),
              leading: Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    print("Radio $val");
                    setSelectedRadio(val);
                  }),
            ),
            ListTile(
              title: const Text("Comprar en KM5"),
              leading: Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    print("Radio $val");
                    setSelectedRadio(val);
                  }),
            ),
            ListTile(
              title: const Text("Domicilio en puerta 7"),
              leading: Radio(
                  value: 3,
                  groupValue: selectedRadio,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    print("Radio $val");
                    setSelectedRadio(val);
                  }),
            ),
            Visibility(
              visible: _visible,
              child: Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: this.controllerCodigo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Código',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _visible,
              child: Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: this.controllerObjeto,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Objeto',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _visible,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: this.controllerCantidad,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cantidad',
                    ),
                  )),
            ),
            Visibility(
              visible: _visible,
              child: Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: this.controllerDetalle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Detalles',
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
