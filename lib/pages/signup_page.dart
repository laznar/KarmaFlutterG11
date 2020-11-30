import 'package:KarmaG11/backend/firebase_auth.dart';
import 'package:KarmaG11/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("G11"),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                      child: Text(
                        'Sign Up Information',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                    child: TextField(
                      controller: this.controllerName,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: this.controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email address',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter email address";
                        } else if (!value.contains('@')) {
                          return "Enter valid email address";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      controller: this.controllerPassword,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter password";
                        } else if (value.length < 6) {
                          return "Password should have at least 6 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      if (_formKey.currentState.validate()) {
                        _signUp(context, controllerEmail.text,
                            controllerPassword.text, controllerName.text, 5);
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  _signUp(BuildContext context, String email, String password, String name,
      int karma) {
    signUpWithFirebase(email, password, name).then((user) {
      print(user);
      _buildDialog(context, "Sign Up", "Sign Up OK").then((value) {
        _formKey.currentState.reset();
        Navigator.of(context).pop();
      });
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
