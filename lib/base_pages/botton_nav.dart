import 'package:KarmaG11/backend/firebase_auth.dart';
import 'package:KarmaG11/pages/chat_page.dart';
import 'package:KarmaG11/pages/favor_board_page.dart';
import 'package:KarmaG11/pages/favor_page.dart';
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
    HomeView(), //home
    FavorPage(), //favor
    FavorBoard(), //board
    ChatPage(), //tus favores
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
        title: const Text('G11'),
        actions: [
          Container(
            width: 160.0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(0),
            child: Image.asset('assets/karma.png', fit: BoxFit.fill),
          ),
          IconButton(
            icon: new CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("5",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500))),
            tooltip: 'Points',
            onPressed: () {},
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
          BottomNavigationBarItem(icon: Icon(Icons.home),backgroundColor: Colors.lightBlue, label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article),backgroundColor: Colors.lightBlue, label: "Favor"),
          BottomNavigationBarItem(icon: Icon(Icons.list),backgroundColor: Colors.lightBlue, label: "Board"),
          BottomNavigationBarItem(icon: Icon(Icons.chat),backgroundColor: Colors.lightBlue, label: "Your Favors"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
