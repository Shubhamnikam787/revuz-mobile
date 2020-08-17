import 'dart:convert';
import 'dart:io';
import 'package:Revuz/model/Review.dart';
import 'package:Revuz/screen/editReviewScreen.dart';
import 'package:Revuz/screen/login_screen.dart';
import 'package:Revuz/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:Revuz/model/Reward.dart';
import 'package:Revuz/screen/profile.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyReviewScreen extends StatefulWidget {
  MyReviewScreen({Key key}) : super(key: key);
  _MYReviewScreen createState() => _MYReviewScreen();
}

class _MYReviewScreen extends State<MyReviewScreen> {
  List<Review> reviews = [];
  final profile = ProfileScreen();
  bool showLoading = true;
  void initState() {
    super.initState();
    profile.getUserId().then((value) async {
      _reviewList(value).then((value) {
        setState(() {
          print("Setting Reviews");
          this.reviews = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Reviews',
          style: TextStyle(
              color: Colors.white, fontFamily: 'OpenSans', fontSize: 20.0),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: _gridView(),
      backgroundColor: Colors.black87,
    );
  }

  Widget _gridView() {
    if (!showLoading) {
      return Container(
        margin: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
        //height: 450.0,
        child: ListView.builder(
            itemCount: reviews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext ctxt, int Index) {
              final review = reviews[Index];
              return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey[850],
                  ),
                  width: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width / 6),
                  height: 450,
                  child: Column(children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/09/04/15/lionel-messi-0.jpg?'))),
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                review.productName.toString(),
                                maxLines: 2,
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Spacer(),
                            //Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditReviewScreen( review: review),
                                  ),
                                );
                              },
                              child: Container(
                                child: Text(
                                  "Edit Review",
                                  style: new TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        review.reviewTitle,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(5),
                        child: IgnorePointer(
                            child: RatingBar(
                          initialRating: review.reviewRating != null
                              ? double.parse(review.reviewRating)
                              : 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 20,
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
                        ))),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        review.reviewDesc,
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                        child: Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                    //margin: EdgeInsets.all(5),
                                    child: Row(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.30,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Hero(
                                        tag: 'imageHeroo',
                                        child: Image.network(
                                          'https://picsum.photos/250?image=9',
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                    //margin: EdgeInsets.all(5),
                                    child: Row(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.30,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Hero(
                                        tag: 'img',
                                        child: Image.network(
                                          'https://picsum.photos/250?image=9',
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              )
                            ]),
                      ),
                    ))
                  ]));
            }),
      );
    } else {
      return Align(
          alignment: Alignment.center, child: CircularProgressIndicator());
    }
  }

  Future<List<Review>> _reviewList(int id) async {
    if (id != null) {
      print("Sending Request");
      final response =
          await http.get('https://rewardz-app.herokuapp.com/review/user/' + id.toString());
      if (response.statusCode == 200) {
        var maps = json.decode(response.body);
        print("maps");
        print(maps);

        List<Review> temp = [];
        for (var i in maps) {
          temp.add(Review(
            id: i["review_id"],
            reviewTitle: i['review_title'],
            productName: i['product_name'],
            reviewRating: i['review_rating'],
            //category: i['category'],
            reviewDesc: i['review_desc'],
            username: i['username'],
          ));
        }
        showLoading = false;
        return temp;
      } else {
        // If the response was umexpected, throw an error.
        throw Exception('Failed to load post');
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      print("User iD nullll");
    }
  }
}
