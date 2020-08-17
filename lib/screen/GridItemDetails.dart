import 'dart:convert';

import 'package:Revuz/model/Review.dart';
import 'package:Revuz/screen/addReviewScreen.dart';
import 'package:Revuz/screen/nav.dart';
import 'package:Revuz/screen/profile.dart';
import 'package:Revuz/screen/videoPlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:Revuz/model/Item.dart';
import 'package:Revuz/screen/GetRatings.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class GridItemDetails extends StatelessWidget {

  final Item item;

  GridItemDetails(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      primary: true,
      appBar: AppBar(
        title: Text(
          item.product_name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: <Widget>[
          HeaderBanner(this.item),
          Container(
            constraints: BoxConstraints(minHeight: 200),
            padding: const EdgeInsets.fromLTRB(22.0, 25.0, 22.0, 20.0),
            child: Text(
              item.desc,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
          GetReviews(this.item.id),
        ],
        // ),
        //],
      ),
    );
  }
}

class HeaderBanner extends StatelessWidget {
  final Item item;

  HeaderBanner(this.item);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      child: Container(
        height: 380.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              child: HeaderImage('assets/images/google.jpg'),
            ),
            HeaderContent(this.item),
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
  final Item item;

  HeaderContent(this.item);

  @override
  Widget build(BuildContext context) {
      return Container(
            //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 0.0),
            //color: Colors.black.withOpacity(0.1),
            decoration: new BoxDecoration(
              color: Colors.grey[850],
            ),
            constraints: BoxConstraints.expand(
              height: 110.0,
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
                            padding: const EdgeInsets.only(bottom: 1.0, left: 5),
                            child: Text(
                              item.product_name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 26.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(5),
                              child: IgnorePointer(
                                  child: RatingBar(
                                initialRating: item.avg_rating != null
                                    ? double.parse(item.avg_rating)
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
                            //margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              "item.time",
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
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddReviewScreen(item: this.item)),
                        );
                      },
                      child: Container(
                        //color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child:Text(
                      "Review",
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
    ));
  }
}

class GetReviews extends StatefulWidget {
  final id;
  
  GetReviews(this.id);
  _GetReviews createState() => _GetReviews(id);
}

class _GetReviews extends State<GetReviews> {
  int id;
  int user_id;
  bool showLoading = true;
  var reviewed = null;
  final profile = ProfileScreen();
  _GetReviews(this.id);

  List<Review> reviews = [];
  void initState() {
    super.initState();
    profile.getUserId().then((value) {
      if (value != null) {
        user_id = value;
      }
    });
    _reviewList(id).then((value) {
      setState(() {
        this.reviews = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!showLoading) {
      if(reviews.length > 0){
        return Container(
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        height: 450,
        child: ListView.builder(
            itemCount: reviews.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext ctxt, int Index) {
              final review = reviews[Index];

              return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey[850],
                  ),
                  width: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width / 6),
                  child: Column(children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              child: Text(
                                review.username,
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
                                    margin: EdgeInsets.all(3),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Hero(
                                            tag: 'imageHero',
                                            child: Image.network(
                                              review.reviewImage != null && review.reviewImage.length > 0
                                                  ? review.reviewImage
                                                  : '',
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              },
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
                                    margin: EdgeInsets.all(3),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            child: review.reviewVideo != null && review.reviewVideo.length > 0
                                                ? Image.network(
                                                    "https://media.istockphoto.com/vectors/play-button-icon-music-and-video-forward-click-shape-symbol-push-vector-id1164686160?k=6&m=1164686160&s=170667a&w=0&h=yJhuX0yGVaWoK5ZFYybUbd_t4vw40Zmka-km1I-fIM4=",
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container()),
                                      ],
                                    )),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            (VideoPlayerScreen())),
                                  );
                                },
                              )
                            ]),
                      ),
                    ))
                  ]));
            }),
      );
      }else{
        return Container();
      }
      
    } else {
      return Align(
          alignment: Alignment.center, child: CircularProgressIndicator());
    }
  }

  Future<List<Review>> _reviewList(int id) async {
    
    final response =
        await http.get('https://rewardz-app.herokuapp.com/review/' + id.toString());
    if (response.statusCode == 200) {
      var maps = json.decode(response.body);
      print("maps");
      print(maps);
      print(user_id);
      if (user_id != null) {
      reviewed = maps.where((review) => review["user_id"] == user_id);
        
      }
      List<Review> temp = [];
      for (var i in maps) {
        temp.add(Review(
          id: i["id"],
          reviewTitle: i['review_title'],
          reviewImage: i['review_image_url'],
          reviewVideo: i['review_video_url'],
          //category: i['category'],
          reviewDesc: i['review_desc'],
          reviewRating: i['review_rating'],
          username: i['username'],
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
