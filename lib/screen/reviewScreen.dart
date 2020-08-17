import 'dart:convert';
import 'dart:io';
import 'package:Revuz/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:Revuz/model/Reward.dart';
import 'package:Revuz/screen/profile.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({Key key}) : super(key: key);
  _ReviewScreen createState() => _ReviewScreen();
}

class _ReviewScreen extends State<ReviewScreen> {
  final profile = ProfileScreen();
  File review_image;
  File review_video;
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
    getProducts().then((value) {
      setState(() {
        this.items = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Review Product',
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
    return Container(
        
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Card(
                margin: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.brown,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: SearchableDropdown.single(
                      items: items,
                      value: productId,
                      hint: "Select Product",
                      searchHint: "Select Select Product",
                      onChanged: (value) {
                        setState(() {
                          productId = value;
                        });
                      },
                      isExpanded: true,
                    ))),
          ),
          Container(
              //padding: EdgeInsets.all(25),
              child: Card(
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.brown,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: TextField(
                controller: reviewTitle,
                maxLines: 1,
                decoration:
                    InputDecoration.collapsed(hintText: "Enter review title"),
              ),
            ),
          )),
          Container(
            //padding: EdgeInsets.all(19),
            child: Card(
                margin: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.brown,
                    width: 0.5,
                  ),
                ),
                child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 2, 7, 2),
                        child: TextField(
                          controller: reviewDesc,
                          maxLines: 4,
                          decoration: InputDecoration.collapsed(
                              hintText: "Enter review description"),
                        )))),
          ),
          Container(
              margin: EdgeInsets.all(5),
              child: RatingBar(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
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
          Row(
            children: <Widget>[
              Container(
                  //padding: EdgeInsets.all(25),
                  child: Card(
                margin: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.brown,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: RaisedButton(
                    onPressed: _choose,
                    child: Text('Choose Image'),
                  ),
                ),
              )),
              Container(
                  //padding: EdgeInsets.all(25),
                  child: Card(
                margin: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.brown,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: RaisedButton(
                    onPressed: _chooseVideo,
                    child: Text('Choose Video'),
                  ),
                ),
              )),
            ],
          ),
          Container(
              //padding: EdgeInsets.all(25),
              child: Card(
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.brown,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: RaisedButton(
                onPressed: () => submitReview(
                    productId,
                    reviewTitle.text.toString(),
                    reviewDesc.text.toString(),
                    review_rating,
                    review_image,
                    review_video),
                child: Text('Submit'),
              ),
            ),
          ))
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

    setState(() {
      review_video = File(pickedFile.path);
      print(review_video);
    });
  }

  Future getProducts() async {
    final response = await http.get('https://rewardz-app.herokuapp.com/product');
    if (response.statusCode == 200) {
      var maps = json.decode(response.body);
      print("maps");
      print(maps);

      List<DropdownMenuItem> temp = [];
      for (var i in maps) {
        print("mapppppppppppppppppppppppppppppppppppp");
        print(i['product_name']);
        print(i['id']);
        temp.add(DropdownMenuItem(
          child: Text(i['product_name']),
          value: i['id'],
        ));
      }
      return temp;
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load products');
    }
  }

  submitReview(
      int product, String title, String desc, double rating, File image, File video) async {
    print(product);
    print(title);
    print(desc);
    print(rating);
    print(image.toString());
    if (product != null && title != null && desc != null && rating != null) {
      profile.getUserId().then((value) async {
        var request = new http.MultipartRequest(
            "POST", Uri.parse('https://rewardz-app.herokuapp.com/review'));
        request.fields['productId'] = product.toString();
        request.fields['reviewTitle'] = title;
        request.fields['reviewDesc'] = desc;
        request.fields['review_rating'] = rating.toString();
        request.fields['userId'] = value.toString();
        print("Sending Request");
        if (image != null) {
          request.files.add(http.MultipartFile(
              'avatar', image.readAsBytes().asStream(), image.lengthSync(),
              filename: review_image.toString().split("/").last.substring(0,review_image.toString().split("/").last.length - 1)));
        }
        if (video != null) {
          request.files.add(http.MultipartFile(
              'video', video.readAsBytes().asStream(), video.lengthSync(),
              filename: video.toString().split("/").last.substring(0,video.toString().split("/").last.length - 1)));
        }

        var res = await request.send();
        print(res.statusCode);
      });
    }
  }
}
