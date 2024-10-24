import 'package:app/models/user/user.dart';

class ChatBuddy {
  int? id;
  String? name;
  int? brokerageHouseId;
  String? lastSendTime;
  User? user;
  String? message;
  String? sendT;
  String? readT;
  int? sendTimeInSec;
  bool? isFavourite;

  bool get favourite => isFavourite ?? false;

  ChatBuddy({
    this.id,
    this.name,
    this.brokerageHouseId,
    this.lastSendTime,
    this.user,
    this.message,
    this.sendT,
    this.readT,
    this.sendTimeInSec,
    this.isFavourite,
  });

  ChatBuddy.fromJson(json) {
    id = json['id'];
    name = json['name'];
    brokerageHouseId = json['brokerage_house_id'];
    lastSendTime = json['last_send_time'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['msg'];
    sendT = json['send_t'];
    readT = json['read_t'];
    sendTimeInSec = json['send_time_in_sec'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['brokerage_house_id'] = brokerageHouseId;
    map['last_send_time'] = lastSendTime;
    if (user != null) map['user'] = user?.toJson();
    map['msg'] = message;
    map['send_t'] = sendT;
    map['read_t'] = readT;
    map['send_time_in_sec'] = sendTimeInSec;
    map['is_favourite'] = isFavourite;
    return map;
  }
}
