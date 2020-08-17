import 'package:meta/meta.dart';

class Item {
  int id;
  String product_name;
  String product_desc;
  
  String desc;
  String avg_rating;
  

  Item({
    @required this.id,
    @required this.product_name,
    @required this.product_desc,
    @required this.desc,
    @required this.avg_rating,
    
  });
}
