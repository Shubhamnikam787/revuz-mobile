import 'dart:convert';
import 'dart:io';
import 'package:Revuz/model/Item.dart';
import 'package:Revuz/screen/GridItemDetails.dart';
import 'package:Revuz/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:Revuz/model/Reward.dart';
import 'package:Revuz/screen/profile.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';

class AddReviewScreen extends StatefulWidget {
  final Item item;

  AddReviewScreen({Key key, @required this.item}) : super(key: key);
  _ReviewScreen createState() => _ReviewScreen(this.item);
}

class _ReviewScreen extends State<AddReviewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final Item item;
  _ReviewScreen(this.item);
  final profile = ProfileScreen();
  File review_image;
  File review_video;
  var _videoPlayerController;
  double review_rating;
  List<Reward> rewardList;

  int productId;

  final picker = ImagePicker();

  List<DropdownMenuItem> items = [];
  final reviewTitle = TextEditingController();
  final reviewDesc = TextEditingController();
  //items = ["One","Two","Three"];
  @override
  void initState() {
    super.initState();
    profile.getUserId().then((value) {
      if (value == null) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              title: Text(
                'Review ' + this.item.product_name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0),
              ),
              backgroundColor: Colors.grey[900]),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: _gridView(),
          ),
          backgroundColor: Colors.grey[850],
        ));
  }

  Widget _gridView() {
    return Container(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
          margin: EdgeInsets.only(top: 30),
          child: Card(
            color: Colors.grey[900],
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.amber,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: TextField(
                style: TextStyle(color: Colors.white),

                controller: reviewTitle,
                maxLines: 1,
                //textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "Review Title",
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )),
      Container(
        //padding: EdgeInsets.all(19),
        child: Card(
            color: Colors.grey[900],
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.amber,
                width: 0.5,
              ),
            ),
            child: Card(
                color: Colors.grey[900],
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 2, 7, 2),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(250),
                      ],
                      maxLength: 250,
                      style: TextStyle(color: Colors.white),
                      controller: reviewDesc,
                      maxLines: 4,
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter Review Description",
                        hintStyle: TextStyle(color: Colors.white),

                        //labelText: "Enter review description"
                      ),
                    )))),
      ),
      Container(
          margin: EdgeInsets.all(14),
          child: RatingBar(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                review_rating = rating;
              });
            },
          )),
      Column(
        children: <Widget>[
          GestureDetector(
              onTap: _choose,
              child: FutureBuilder(
                builder: (context, data) {
                  if (review_image != null) {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.width * 0.30,
                        //padding: EdgeInsets.all(25),
                        child: Card(
                          color: Colors.grey[900],
                          margin: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.amber,
                              width: 0.5,
                            ),
                          ),
                          child: Image.file(
                            review_image,
                            fit: BoxFit.fill,
                            //height: 200.0,
                          ),
                        ));
                  } else {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.width * 0.30,
                        //padding: EdgeInsets.all(25),
                        child: Card(
                          color: Colors.grey[900],
                          margin: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.amber,
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Center(
                                child: Text('Choose Image',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ));
                  }
                },
              )),
          GestureDetector(
              onTap: _chooseVideo,
              child: FutureBuilder(
                builder: (context, data) {
                  if (review_video != null) {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.width * 0.30,
                        //padding: EdgeInsets.all(25),
                        child: Card(
                            color: Colors.grey[900],
                            margin: EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.amber,
                                width: 0.5,
                              ),
                            ),
                            child: AspectRatio(
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            )));
                  } else {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.width * 0.30,
                        //padding: EdgeInsets.all(25),
                        child: Card(
                          color: Colors.grey[900],
                          margin: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.amber,
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Center(
                                child: Text(
                              'Choose Video',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ));
                  }
                },
              )),
        ],
      ),
      Container(
          margin: EdgeInsets.only(top: 15),
          //padding: EdgeInsets.all(25),
          child: GestureDetector(
              onTap: () => submitReview(
                  this.item.id,
                  reviewTitle.text.toString(),
                  reviewDesc.text.toString(),
                  review_rating,
                  review_image,
                  review_video),
              child: Card(
                margin: EdgeInsets.all(12),
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: Colors.yellowAccent,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ))),
    ])));
  }

  Future _choose() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      review_image = File(pickedFile.path);
      print(review_image);
    });
  }

  Future _chooseVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    File _video = File(pickedFile.path);
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        _videoPlayerController.play();
      });
    setState(() {
      review_video = File(pickedFile.path);
      print(review_video);
    });
  }

  submitReview(int product, String title, String desc, double rating,
      File image, File video) async {
    print(product);
    print(title);
    print(desc);
    print(rating);
    print(image.toString());
    if (product != null &&
        title != null &&
        title.length > 0 &&
        desc != null &&
        desc.length > 0 &&
        rating != null) {
      profile.getUserId().then((value) async {
        var request = new http.MultipartRequest(
            "POST", Uri.parse('https://rewardz-app.herokuapp.com/review'));
        request.fields['productId'] = product.toString();
        request.fields['reviewTitle'] = title;
        request.fields['reviewDesc'] = desc.replaceAll("\n", " ");
        request.fields['review_rating'] = rating.toString();
        request.fields['userId'] = value.toString();
        print("Sending Request");
        if (image != null) {
          request.files.add(http.MultipartFile(
              'avatar', image.readAsBytes().asStream(), image.lengthSync(),
              filename: review_image.toString().split("/").last.substring(
                  0, review_image.toString().split("/").last.length - 1)));
        }
        if (video != null) {
          request.files.add(http.MultipartFile(
              'video', video.readAsBytes().asStream(), video.lengthSync(),
              filename: video.toString().split("/").last.substring(
                      0, video.toString().split("/").last.indexOf('.')) +
                  '.mp4'));
        }
        var res = await request.send();
        print(res.statusCode);
        if (res.statusCode == 200) {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => GridItemDetails(this.item)));
        } else {
          
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: new Container(
              child: Text("Review Already Submitted for this product",
                  textAlign: TextAlign.center),
            ),
            duration: new Duration(seconds: 2),
          ));
        }
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: new Container(
          child: Text("Title, Description and Rating is required",
              textAlign: TextAlign.center),
        ),
        duration: new Duration(seconds: 2),
      ));
    }
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => GridItemDetails(this.item)));
  }
}
