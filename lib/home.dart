import "package:flutter/material.dart";
import 'package:homeservice/MainPage.dart';
import 'package:homeservice/Profile.dart';
import 'Profile.dart';
import 'Search.dart';

class Homescreen extends StatefulWidget {

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>{
  int _currentIndex = 0;
  final List<Widget> _children =
      [
        MainPage(),
        Search(),
        Profile(),
      ];
  void onTappedBar(int index)
  {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
    child: Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Search'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
          ),
        ],
      ),
    ));
  }
  }

