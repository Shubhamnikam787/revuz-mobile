import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Revuz/model/Reward.dart';
import 'package:Revuz/screen/RewardList.dart';
import 'package:Revuz/screen/vouchers.dart';
import 'package:http/http.dart' as http;

import 'SplashScreen.dart';

class VoucherScreen extends StatefulWidget {
  final voucherList;
  
  VoucherScreen(this.voucherList);

  _VoucherScreen createState() => _VoucherScreen(voucherList);
}

class _VoucherScreen extends State<VoucherScreen> {
  List<Reward> voucherList;

  _VoucherScreen(this.voucherList);
  
  
  @override
  // void initState() {
  //   super.initState();
    
      
    
  // }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Vouchers',
          style: TextStyle(
              color: Colors.white, fontFamily: 'OpenSans', fontSize: 20.0),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: _gridView(),
    );
  }

  Widget _gridView() {
    if (voucherList != null) {
      return GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(4.0),
        childAspectRatio: 8.0 / 9.0,
        children: voucherList
            .map(
              (Reward) => Vouchers(vouchers: Reward),
            )
            .toList(),
      );
    } else {
      return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            
          ));
    }
  }

  Future<List<Reward>> _itemList() async {
    final response = await http.get('https://rewardz-app.herokuapp.com/reward');
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
      return temp;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  // return [
  //   Reward(
  //     id: 0,
  //     rewardTitle: 'Amazon 500 Cashback  ',
  //     rewardDesc: 'A company overview (also known as company information or a company summary) '
  //         'is an essential part of a business plan. '
  //         'A company overview (also known as company information or a company summary) '
  //         'is an essential part of a business plan.'
  //         'A company overview (also known as company information or a company summary) '
  //         'to protect the world from threats too large for '
  //         'any one hero to handle, a danger has emerged '
  //         'from the cosmic shadows: Thanos.',
  //     requiredPoints: 200

  //   ),
  //   Reward(
  //     id: 0,
  //     rewardTitle: 'Amazon 500 Cashback  ',
  //     rewardDesc: 'A company overview (also known as company information or a company summary) '
  //         'is an essential part of a business plan. '
  //         'A company overview (also known as company information or a company summary) '
  //         'is an essential part of a business plan.'
  //         'A company overview (also known as company information or a company summary) '
  //         'to protect the world from threats too large for '
  //         'any one hero to handle, a danger has emerged '
  //         'from the cosmic shadows: Thanos.',
  //     requiredPoints: 200
  //   )
  //     Item(
  //       id: 0,
  //       name: 'Amazon 500 Cashback ',
  //       category: 'My category',
  //       desc: 'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan. '
  //           'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan.'
  //           'A company overview (also known as company information or a company summary) '
  //           'to protect the world from threats too large for '
  //           'any one hero to handle, a danger has emerged '
  //           'from the cosmic shadows: Thanos.',
  //       rating: 8.7,
  //       directors: 'Director: Jermiah Wilson',
  //       city: 'Pune',
  //       releaseDateDesc: 'USA (2018), 2h 29min',
  //       time: '200',
  //       bannerUrl: 'assets/images/giftcard.jpg',
  //       imageUrl: 'assets/images/ic_preview_1.png',
  //       trailerImg1: 'assets/images/giftcard.jpg',
  //       trailerImg2: 'assets/images/ic_thumb_12.png',
  //       trailerImg3: 'assets/images/ic_thumb_13.png',
  //     ),
  //     Item(
  //       id: 0,
  //       name: 'Amazon 500 Cashback ',
  //       category: 'My category',
  //       desc: 'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan. '
  //           'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan.'
  //           'A company overview (also known as company information or a company summary) '
  //           'to protect the world from threats too large for '
  //           'any one hero to handle, a danger has emerged '
  //           'from the cosmic shadows: Thanos.',
  //       rating: 8.7,
  //       directors: 'Director: Jermiah Wilson',
  //       city: 'Pune',
  //       releaseDateDesc: 'USA (2018), 2h 29min',
  //       time: '200',
  //       bannerUrl: 'assets/images/giftcard.jpg',
  //       imageUrl: 'assets/images/ic_preview_1.png',
  //       trailerImg1: 'assets/images/giftcard.jpg',
  //       trailerImg2: 'assets/images/ic_thumb_12.png',
  //       trailerImg3: 'assets/images/ic_thumb_13.png',
  //     ),
  //     Item(
  //       id: 0,
  //       name: 'Amazon 500 Cashback ',
  //       category: 'My category',
  //       desc: 'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan. '
  //           'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan.'
  //           'A company overview (also known as company information or a company summary) '
  //           'to protect the world from threats too large for '
  //           'any one hero to handle, a danger has emerged '
  //           'from the cosmic shadows: Thanos.',
  //       rating: 8.7,
  //       directors: 'Director: Jermiah Wilson',
  //       city: 'Pune',
  //       releaseDateDesc: 'USA (2018), 2h 29min',
  //       time: '200',
  //       bannerUrl: 'assets/images/giftcard.jpg',
  //       imageUrl: 'assets/images/ic_preview_1.png',
  //       trailerImg1: 'assets/images/giftcard.jpg',
  //       trailerImg2: 'assets/images/ic_thumb_12.png',
  //       trailerImg3: 'assets/images/ic_thumb_13.png',
  //     ),
  //     Item(
  //       id: 0,
  //       name: 'Amazon 500 Cashback ',
  //       category: 'My category',
  //       desc: 'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan. '
  //           'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan.'
  //           'A company overview (also known as company information or a company summary) '
  //           'to protect the world from threats too large for '
  //           'any one hero to handle, a danger has emerged '
  //           'from the cosmic shadows: Thanos.',
  //       rating: 8.7,
  //       directors: 'Director: Jermiah Wilson',
  //       city: 'Pune',
  //       releaseDateDesc: 'USA (2018), 2h 29min',
  //       time: '200',
  //       bannerUrl: 'assets/images/giftcard.jpg',
  //       imageUrl: 'assets/images/ic_preview_1.png',
  //       trailerImg1: 'assets/images/giftcard.jpg',
  //       trailerImg2: 'assets/images/ic_thumb_12.png',
  //       trailerImg3: 'assets/images/ic_thumb_13.png',
  //     ),
  //     Item(
  //       id: 0,
  //       name: 'Amazon 500 Cashback ',
  //       category: 'My category',
  //       desc: 'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan. '
  //           'A company overview (also known as company information or a company summary) '
  //           'is an essential part of a business plan.'
  //           'A company overview (also known as company information or a company summary) '
  //           'to protect the world from threats too large for '
  //           'any one hero to handle, a danger has emerged '
  //           'from the cosmic shadows: Thanos.',
  //       rating: 8.7,
  //       directors: 'Director: Jermiah Wilson',
  //       city: 'Pune',
  //       releaseDateDesc: 'USA (2018), 2h 29min',
  //       time: '200',
  //       bannerUrl: 'assets/images/giftcard.jpg',
  //       imageUrl: 'assets/images/ic_preview_1.png',
  //       trailerImg1: 'assets/images/giftcard.jpg',
  //       trailerImg2: 'assets/images/ic_thumb_12.png',
  //       trailerImg3: 'assets/images/ic_thumb_13.png',
  //     )
  // ];
  // }
}
