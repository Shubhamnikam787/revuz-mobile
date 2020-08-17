import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Revuz/screen/nav.dart';
import 'package:Revuz/screen/utilities/constants.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController refferalController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: usernameController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Username',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRefferalTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Refferal Code',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: refferalController,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter Refferal Code ',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => signup(
            emailController.text.toString(),
            refferalController.text.toString(),
            usernameController.text,
            context),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white, fontFamily: 'OpenSans', fontSize: 20.0),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: Colors.grey[850],
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //     colors: [
                //       Colors.blueGrey[900],
                //       Colors.blueGrey[900],
                //      Colors.blueGrey[900],
                //       Colors.blueGrey[900]
                //     ],
                //     stops: [0.1, 0.4, 0.7, 0.9],
                //   ),
                // ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildUsernameTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildRefferalTF(),
                      _buildLoginBtn(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signup(String email, String refferal, String username, context) async {
    if (email.length > 0 && username.length > 0) {
      final response = await http.post('https://rewardz-app.herokuapp.com/user',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username.toString(),
            'refferal_code': refferal.toString(),
            'email': email.toString(),
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: new Container(
            child: Text("Sign Up Complete", textAlign: TextAlign.center),
          ),
          duration: new Duration(seconds: 2),
        ));
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: new Container(
            child: Text("Confirm Email and password on email", textAlign: TextAlign.center),
          ),
          duration: new Duration(seconds: 2),
        ));
        
      } else {
        var responseBody = json.decode(response.body);

        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: new Container(
            child: Text(responseBody['message'], textAlign: TextAlign.center),
          ),
          duration: new Duration(seconds: 2),
        ));
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: new Container(
          child: Text("Uername and Email is required",
              textAlign: TextAlign.center),
        ),
        duration: new Duration(seconds: 2),
      ));
    }
  }

  Future<void> saveUser(user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', user["id"]);
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (BuildContext context) => Nav(3)));
  }

  // Future<bool> _onBackPressed() {
  //   Navigator.of(context).pushReplacement(
  //       new MaterialPageRoute(builder: (BuildContext context) => Nav(0)));
  // }
}
