import 'package:Revuz/screen/editReviewScreen.dart';
import 'package:Revuz/screen/myReviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:Revuz/constant/Constant.dart';
import 'package:Revuz/screen/HomeScreen.dart';
import 'package:Revuz/screen/SplashScreen.dart';
import 'package:Revuz/screen/app_theme.dart';
import 'package:Revuz/screen/nav.dart';

void main() => runApp(MaterialApp(
      title: 'Rewardz',
      builder: (context, child) => SafeArea(
        top: true,
        bottom: true,
        child: child),
      home: SplashScreens(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: AppTheme.textTheme,
            
      ),
      routes: <String, WidgetBuilder>{
        HOME_SCREEN: (BuildContext context) => HomeScreen(),
        
        

        //GRID_ITEM_DETAILS_SCREEN: (BuildContext context) => GridItemDetails(),
      },
    ));
    class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  
}
