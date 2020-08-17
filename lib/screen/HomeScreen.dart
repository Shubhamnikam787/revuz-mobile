import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Revuz/model/Item.dart';
import 'package:Revuz/screen/ItemList.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Item> productList;
  List<Item> productListFilter;

  bool showLoading = true;

  Widget appBarTitle = new Text(
    "Browse Reviews",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;

  void initState() {
    super.initState();
    _productList().then((value) {
      setState(() {
        this.productList = value;
        this.productListFilter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: appBarTitle,
          backgroundColor: Colors.grey[850],
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(
                      Icons.close,
                      color: Colors.white,
                    );
                    this.appBarTitle = new TextField(
                      onChanged: (text) {
                        print("First text field: $text");
                        var temp = productList
                            .where((x) => x.product_name
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                            .toList();
                        setState(() {
                          this.productListFilter = temp;
                        });
                        
                      },
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white)),
                    );
                    _handleSearchStart();
                  } else {
                    _handleSearchEnd();
                  }
                });
              },
            ),
          ]),
      body: _gridView(),
      backgroundColor: Colors.grey[900],
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.productListFilter = this.productList;
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Browse Reviews",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  Widget _gridView() {
    if (!showLoading) {
      return Container(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(4.0),
            childAspectRatio: 8.0 / 10.5,
            children: productListFilter
                .map(
                  (Item) => ItemList(item: Item),
                )
                .toList(),
          ));
    } else {
      return Align(
          alignment: Alignment.center, child: CircularProgressIndicator());
    }
  }

  Future<List<Item>> _productList() async {
    final response = await http.get('https://rewardz-app.herokuapp.com/product');
    if (response.statusCode == 200) {
      var maps = json.decode(response.body);
      print("maps");
      print(maps);

      List<Item> temp = [];
      for (var i in maps) {
        temp.add(Item(
          id: i["id"],
          product_name: i['product_name'],
          //category: i['category'],
          desc: i['product_desc'],
          avg_rating: i['average_rating'],
        ));
      }
      showLoading = false;
      return temp;
    } else {
      showLoading = false;
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load products');
    }
  }
  
}
