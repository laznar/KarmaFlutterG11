import 'package:KarmaG11/backend/firebase_auth.dart';
import 'package:KarmaG11/pages/signup_page.dart';
import 'package:KarmaG11/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("G11"),
        ),
        body: SingleChildScrollView(
          child: Center(

            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  child: Image.asset('assets/karma.png'),/*Text(
                        'KARMA',
                        style: TextStyle(
                            color: Colors.indigo[900],
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )*/),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),

                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: this.controllerEmail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(

                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: this.controllerPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Consumer<AuthProvider>(builder: (context, model, child) {
                      return

                        Container(
                          margin: EdgeInsets.all(10),
                          child:RaisedButton(

                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          onPressed: () {
                            _login(context, controllerEmail.text.trim(),
                                controllerPassword.text, model);
                          },
                        )
                        );
                    }),
                    Consumer<AuthProvider>(builder: (context, model, child) {
                      return Container(
                          margin: EdgeInsets.all(10),
                          child:RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => SignInView()));
                          },
                      )
                      );
                    })
                  ],


                ),


              ],
            ),
          ),
        ));
  }

  _login(
      BuildContext context, String email, String password, AuthProvider model) {
    signInWithFirebase(email, password).then((user) {
      print(user);
      _buildDialog(context, "Login", "Login OK");
      model.setLogged();
    }).catchError((error) {
      _buildDialog(context, "Login", error.toString());
    });
  }

  _signUp(BuildContext context, String email, String password, String name,
      AuthProvider model) {
    signUpWithFirebase(email, password, name).then((user) {
      print(user);
      _buildDialog(context, "Login", "Login OK");
    }).catchError((error) {
      _buildDialog(context, "Sign Up", error.toString());
    });
  }

  Future<void> _buildDialog(BuildContext context, _title, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
