import 'package:flutter/material.dart';
import 'package:Revuz/model/Item.dart';
import 'package:Revuz/screen/GetRatings.dart';
import 'package:Revuz/screen/GridItemDetails.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemList extends StatelessWidget {
  final Item item;

  const ItemList({@required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GridItemDetails(this.item),
            ),
          );
        },
        child: Container(
          child: Card(
            elevation: 1.0,
            color: Colors.white,
          
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color:Colors.white),
                    //borderRadius: BorderRadius.circular(25.0)
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: AspectRatio(
                    aspectRatio: 18.0 / 14.0,
                    child: Image.asset(
                      'assets/images/google.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          item.product_name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "item.category",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(height: 0.0),
                      Container(
                          margin: EdgeInsets.all(5),
                          child: IgnorePointer(
                              child: Center(
                                  child: RatingBar(
                            initialRating: item.avg_rating != null ? double.parse(item.avg_rating)  : 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              // setState(() {
                              //   review_rating = rating;
                              // });
                            },
                          )))),
                      //GetRatings(),
                      SizedBox(height: 2.0),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: <Widget>[
                      //     Container(
                      //       margin: EdgeInsets.only(right: 4.0),
                      //       child: Column(
                      //         children: <Widget>[
                      //           Text(
                      //             'CITY:',
                      //             style: TextStyle(
                      //               color: Colors.black38,
                      //               fontSize: 10.0,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           Text(
                      //             "item.city",
                      //             style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 10.0,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class HeaderContent extends StatelessWidget {
  final Item item;

  HeaderContent(this.item);

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
                    item.product_name,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFD73C29),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "item.category",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 9.0,
                    ),
                  ),
                  GetRatings(),
                  MovieDesc(this.item),
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
  final Item item;

  MovieDesc(this.item);

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
                  "item.city",
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
                  "item.time",
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
