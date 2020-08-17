import 'dart:convert';

import 'package:Revuz/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:Revuz/model/Reward.dart';
import 'package:Revuz/screen/HomeScreen.dart';
import 'package:Revuz/screen/voucherScreen.dart';
import 'package:Revuz/screen/vouchers.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'nav.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);
  _ProfileScreen createState() => _ProfileScreen();

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId');
    print("userId");
    print(userId);

    if (userId != null) {
      return userId;
    }else{
      return null;
    }
  }
}

class _ProfileScreen extends State<ProfileScreen> {
  final String url =
      'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/09/04/15/lionel-messi-0.jpg?';
  final Color green = Color(0xFF527DAA);

  var user = {};
  List<Reward> voucherList;
  @override
  void initState() {
    super.initState();
    getUserData();
    print(user);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
              color: Colors.white, fontFamily: 'OpenSans', fontSize: 20.0),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: profileView(),
    );
  }

  profileView() {
    if (user != null && user.length > 0) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16),
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            //height:320,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32)),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text('Reward Points',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'RobotoSlab',
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Text(
                            user['reward_points'] != null
                                ? user['reward_points'].toString()
                                : 'Loading ... ',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill, image: NetworkImage(url))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Badge Points',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'RobotoSlab',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            user['badge_points'] != null
                                ? user['badge_points'].toString()
                                : 'Loading ... ',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    user['refferal'] != null
                        ? "Refferal : " + user['refferal'].toString()
                        : "Refferal : Loading ...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    user['current_badge'] != null
                        ? "Badge: " + user['current_badge'].toString()
                        : "Badge: Loading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  child: Text(
                    user['username'] != null ? user['username'] : "Loading... ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Column(
                //         children: <Widget>[
                //           Icon(Icons.group_add, color: Colors.white,),
                //           Text('Friends',
                //             style: TextStyle(
                //               color: Colors.white
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: <Widget>[
                //           Icon(Icons.group, color: Colors.white,),
                //           Text('Groups',
                //             style: TextStyle(
                //                 color: Colors.white
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: <Widget>[
                //           Icon(Icons.videocam, color: Colors.white,),
                //           Text('Videos',
                //             style: TextStyle(
                //                 color: Colors.white
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: <Widget>[
                //           Icon(Icons.favorite, color: Colors.white,),
                //           Text('Likes',
                //             style: TextStyle(
                //                 color: Colors.white
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            padding: EdgeInsets.all(42),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  (VoucherScreen(voucherList))),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.table_chart,
                            color: Colors.white,
                          ),
                          Text(
                            'Vouchers',
                            style: TextStyle(
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        share();
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.show_chart,
                            color: Colors.white,
                          ),
                          Text(
                            'Reffer Friend',
                            style: TextStyle(
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.card_giftcard,
                          color: Colors.white,
                        ),
                        Text(
                          'Change Profile',
                          style: TextStyle(
                              color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.code,
                          color: Colors.white,
                        ),
                        Text('Help',
                        style: TextStyle(
                              color: Colors.white),)
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.blur_circular,
                          color: Colors.white,
                        ),
                        Text('Change Password',
                        style: TextStyle(
                              color: Colors.white),)
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        logout(context);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ),
                          Text('Logout',
                          style: TextStyle(
                              color: Colors.white),)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return Align(
          alignment: Alignment.center, child: CircularProgressIndicator());
    }
  }

  Future getUserData() async {
    var userId;
    getUserId().then((value) async {
      userId = value;
      print("userId.........;;;;;;;;;;");
      print(userId);
      if (userId != null) {
        final response =
            await http.get('https://rewardz-app.herokuapp.com/user/' + userId.toString());
        if (response.statusCode == 200) {
          var userres = json.decode(response.body);
          print("Api response");
          print(userres);
          getVouchers(userId).then((value) {
            setState(() {
              user = userres;
              this.voucherList = value;
            });
          });
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        print("User iD nullll");
      }
    });
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId');
    print("userId");

    print(userId);
    return userId;
  }

  Future<List<Reward>> getVouchers(userId) async {
    final response =
        await http.get('https://rewardz-app.herokuapp.com/voucher/' + userId.toString());
    if (response.statusCode == 200) {
      var maps = json.decode(response.body);
      print(maps);
      List<Reward> temp = [];

      for (var i in maps) {
        temp.add(Reward(
          id: i["id"],
          rewardTitle: i['reward_title'],
          rewardDesc: i['reward_desc'],
          requiredPoints: i['required_points'],
        ));
      }
      return temp;
    }
  }

  Future<void> share() async {
    print("New share pressed");
    await FlutterShare.share(
        title: 'Example share Title',
        text: 'Example share text',
        linkUrl: 'https://www.shubhamnikam.in',
        chooserTitle: 'Example Chooser Title');
  }
}

logout(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs?.clear();
  Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (BuildContext context) => Nav(0)));
}
