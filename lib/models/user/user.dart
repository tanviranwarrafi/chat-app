import 'package:app/extensions/string_ext.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? avatar;
  String? profession;
  String? city;
  String? postalCode;
  String? province;
  String? street;
  String? deletedAt;

  String get name_initial => name.name_initial;
  String get first_name => name == null ? '' : name!.split(' ').first;
  bool get is_social_login => false;
  // bool get is_social_login => provider != null && provider.toKey != 'jwt'.toKey;

  User({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.profession,
    this.city,
    this.postalCode,
    this.province,
    this.street,
    this.deletedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    profession = json['profession'];
    city = json['city'];
    postalCode = json['postalCode'];
    province = json['province'];
    street = json['street'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['avatar'] = avatar;
    map['profession'] = profession;
    map['city'] = city;
    map['postalCode'] = postalCode;
    map['province'] = province;
    map['street'] = street;
    map['deletedAt'] = deletedAt;
    return map;
  }
}
