import 'package:flutter/material.dart';
import 'package:Revuz/model/Reward.dart';
import 'package:Revuz/screen/GetRatings.dart';
import 'package:Revuz/screen/rewardItemDetail.dart';

class RewardList extends StatelessWidget {
  final Reward reward;
  

  const RewardList({@required this.reward, Reward rewardList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RewardItemDetails(this.reward),
          ),
        );
      },
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 12.0,
              child: Image.asset(
                'assets/images/giftcard.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 6.0),
            new Padding(
              padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    reward.rewardTitle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 4.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Points Required:',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 4.0,top: 5.0),
                        child: Column(
                          children: <Widget>[
                            
                            Text(
                              reward.requiredPoints.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.rewardTitle,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFD73C29),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    reward.rewardTitle,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 9.0,
                    ),
                  ),
                  GetRatings(),
                  MovieDesc(this.reward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDesc extends StatelessWidget {
  final Reward reward;

  MovieDesc(this.reward);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  'City:',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  reward.rewardTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'TIME:',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  reward.rewardTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
