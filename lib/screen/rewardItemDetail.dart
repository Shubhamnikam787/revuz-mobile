import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Revuz/model/Reward.dart';
import 'package:Revuz/screen/GetRatings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'nav.dart';

class RewardItemDetails extends StatelessWidget {
  final Reward reward;

  RewardItemDetails(this.reward);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(reward.rewardTitle,
            style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: <Widget>[
          HeaderBanner(this.reward),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: Text(
              reward.rewardDesc,
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.white,
                fontFamily: 'RobotoSlab',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
        // ),
        //],
      ),
    );
  }
}

class GetTags extends StatelessWidget {
  GetTags();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10.0),
      height: 35.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[],
      ),
    );
  }
}

class SetTagsItem extends StatelessWidget {
  final String tag;

  SetTagsItem(this.tag);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        width: 100.0,
        height: 35.0,
        margin: EdgeInsets.only(
          left: 5.0,
          right: 5.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF761322),
          border: Border.all(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            tag,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class HeaderBanner extends StatelessWidget {
  final Reward reward;

  HeaderBanner(this.reward);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      child: Container(
        height: 380.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            HeaderImage('assets/images/giftcard.jpg'),
            HeaderContent(this.reward),
          ],
        ),
      ),
    );
  }
}

class HeaderImage extends StatelessWidget {
  final String bannerUrl;

  HeaderImage(this.bannerUrl);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      bannerUrl,
      width: 600.0,
      height: 380.0,
      fit: BoxFit.cover,
    );
  }
}

class HeaderContent extends StatelessWidget {
  final Reward reward;

  HeaderContent(this.reward);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 0.0),
        //color: Colors.black.withOpacity(0.1),
        decoration: new BoxDecoration(
          color: Colors.grey[850],
        ),
        constraints: BoxConstraints.expand(
          height: 100.0,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 3.0),
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Text(
                          reward.rewardTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          "Reward Points : " + reward.requiredPoints.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    redeemReward(reward, context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Redeem",
                      style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w700),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.amber,
                    ),
                  ),
                )
              ],
            ),
          ),
          //child:
        ),
      ),
    );
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId');
    print("userId");

    print(userId);
    return userId;
  }

  redeemReward(reward, context) async {
    print(reward);
    getUserId().then((value) async {
      var userId = value;
      print("userId.........;;;;;;;;;;");
      print(userId);
      if (userId != null) {
        if (reward != null) {
          final response = await http.put(
              'https://rewardz-app.herokuapp.com/reward-redeem/' + reward.id.toString(),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'reward_id': reward.id.toString(),
                'reward_points': reward.requiredPoints.toString(),
                'user_id': userId.toString(),
              }));

          if (response.statusCode == 200) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => Nav(2)));
          } else {
            var responseBody = json.decode(response.body);
            
            // NavState._scaffoldKey.currentState.showSnackBar(SnackBar(
            //   content: new Container(
            //     child:
            //         Text(responseBody['message'], textAlign: TextAlign.center),
            //   ),
            //   duration: new Duration(seconds: 2),
            // ));
          }
        }
      }
    });
  }
}

class GetTrailers extends StatelessWidget {
  final Reward reward;

  GetTrailers(this.reward);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[],
      ),
    );
  }
}
