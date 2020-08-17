import 'package:Revuz/screen/myReviewScreen.dart';
import 'package:Revuz/screen/reviewScreen.dart';
import 'package:Revuz/screen/videoPlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:Revuz/screen/login_screen.dart';
import 'package:Revuz/screen/profile.dart';
import 'HomeScreen.dart';
import 'RewardScreen.dart';

class Nav extends StatefulWidget {
  final i;
  Nav( this.i);

  @override
  State<StatefulWidget> createState() {
    return NavState(i);
  }
}

class NavState extends State<Nav> {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedTab ;
  int p_id ;

  NavState(this._selectedTab);

  final _pageOptions = [
    HomeScreen(),
    MyReviewScreen(),
    //LoginScreen(),
    RewardScreen(),
    ProfileScreen(),
  ];

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('My Reviews'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              title: Text('Rewards'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }

 
}
