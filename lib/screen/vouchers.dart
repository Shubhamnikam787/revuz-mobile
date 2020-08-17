import 'package:flutter/material.dart';
import 'package:Revuz/model/Reward.dart';
import 'package:Revuz/screen/rewardItemDetail.dart';

class Vouchers extends StatelessWidget {
  final Reward vouchers;

  const Vouchers({@required this.vouchers});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => RewardItemDetails(this.user),
        //   ),
        // );
      },
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
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
            SizedBox(height: 10.0,),
            new Padding(
              padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      vouchers.rewardTitle.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.grey[900],
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4.0, top: 7.0),
                    child: Text(
                      vouchers.rewardDesc.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey[900],
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.only(left: 4.0, top: 7.0),
                    child: Text(
                      "Reedem Code: 54564sccc",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
