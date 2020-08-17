import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Revuz/model/Reward.dart';
import 'package:Revuz/screen/RewardList.dart';
import 'package:http/http.dart' as http;

import 'SplashScreen.dart';

class RewardScreen extends StatefulWidget {
  RewardScreen({Key key}) : super(key: key);
  _RewardScreen createState() => _RewardScreen();
}

class _RewardScreen extends State<RewardScreen> {
  List<Reward> rewardList;
  bool showLoading = true;
  @override
  void initState() {
    super.initState();
    _itemList().then((value) {
      setState(() {
        this.rewardList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Browse Rewards',
          style: TextStyle(
              color: Colors.white, fontFamily: 'OpenSans', fontSize: 20.0),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: _gridView(),
    );
  }

  Widget _gridView() {
    if (!showLoading) {
      return Container(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(4.0),
            childAspectRatio: 8.0 / 9.0,
            children: rewardList
                .map(
                  (Reward) => RewardList(reward: Reward),
                )
                .toList(),
          ));
    } else {
      return Align(
          alignment: Alignment.center, child: CircularProgressIndicator());
    }
  }

  Future<List<Reward>> _itemList() async {
    final response = await http.get('https://rewardz-app.herokuapp.com/reward-available');
    if (response.statusCode == 200) {
      var maps = json.decode(response.body);
      print("maps");
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
      showLoading = false;
      return temp;
    } else {
      showLoading = false;
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }


}
