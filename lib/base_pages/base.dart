import 'package:KarmaG11/base_pages/botton_nav.dart';
import 'package:KarmaG11/pages/login_page.dart';
import 'package:KarmaG11/providers/authProvider.dart';
import 'package:KarmaG11/providers/businessLogicProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Karma G11',
            home: Consumer<AuthProvider>(
              builder: (context, model, child) {
                if (model.getLogged) {
                  return BottonNavigator();
                } else {
                  return LoginView();
                }
              },
            )));
  }
}

class BaseHomeApp extends StatelessWidget {
  const BaseHomeApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BusinessLogicProvider>(
        create: (context) => BusinessLogicProvider(), child: HomePage());
  }
}
