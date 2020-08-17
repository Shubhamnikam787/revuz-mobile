import 'package:meta/meta.dart';

class Reward {
  int id;
  String rewardTitle;
  String rewardDesc;
  int requiredPoints;

  

  Reward( {
    @required this.id, 
    @required this.rewardTitle, 
    @required this.rewardDesc, 
    @required this. requiredPoints});  

  // factory Reward.fromJson(Map<String, dynamic> json) {
  //   var list = json as List;
  //   list.map((i){

  //   });
  //   return Reward(
  //     json['id'] as int,
  //     json['reward_title'] as String,
  //     json['reward_desc'] as String,
  //     json['required_points'] as String,
  //   );
  // }
}
