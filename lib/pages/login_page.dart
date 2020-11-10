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
          title: Text("Karma G11"),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('LogIn'),
              TextFormField(
                controller: this.controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email address"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: this.controllerPassword,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              ),
              Consumer<AuthProvider>(builder: (context, model, child) {
                return FlatButton(
                  onPressed: () {
                    _login(context, controllerEmail.text.trim(),
                        controllerPassword.text, model);
                  },
                  child: Text('Login'),
                );
              }),
              Consumer<AuthProvider>(builder: (context, model, child) {
                return FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignInView()));
                  },
                  child: Text('Sign Up'),
                );
              })
            ],
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
