import 'package:KarmaG11/backend/firebase_auth.dart';
import 'package:KarmaG11/pages/chat_page.dart';
import 'package:KarmaG11/pages/home_page.dart';
import 'package:KarmaG11/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottonNavigator extends StatefulWidget {
  @override
  _BottonNavigatorState createState() => _BottonNavigatorState();
}

class _BottonNavigatorState extends State<BottonNavigator> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    ChatPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KARMA G11'),
        actions: [
          IconButton(
            icon: new CircleAvatar(
                backgroundColor: Colors.red,
                child: Text("0",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500))),
            tooltip: 'Points', onPressed: () {  },
          ),
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                signOutFirebase();
                Provider.of<AuthProvider>(context, listen: false).setLogged();
              }),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Favors"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Favors"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
