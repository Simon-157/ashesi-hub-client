import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String username;
  late String email;
  late String year_group;
  late String best_food;
  late String best_movie;
  late String user_id;
  late String major;
  late String avatar_url;
  late String residence;
  late bool isOnline;

  // late DateTime date_of_birth;

  UserModel(
      {required this.username,
      required this.email,
      required this.user_id,
      required this.major,
      required this.year_group,
      required this.best_food,
      required this.best_movie,
      required this.residence,
      required this.avatar_url});

  UserModel.fromJson(json) {
    username = json['first_name'];
    email = json['email_or_phone'];
    user_id = json['user_id'];
    major = json['major'];
    year_group = json['year_group'];
    best_food = json['best_food'];
    best_movie = json['best_movie'];
    residence = json['residence'];
    avatar_url = json['avatar_url'];
    // DateTime.fromMillisecondsSinceEpoch(json['date_of_birth'] * 1000);
  }

 Map<String, dynamic> toJson(Future<DocumentSnapshot<Object?>> future) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = username;
    data['email_or_phone'] = email;
    data['major'] = major;
    data['year_group'] = year_group;
    data['best_food'] = best_food;
    data['user_id'] = user_id;
    data['avatar_url'] = avatar_url;
    data['best_movie'] = best_movie;
    data['residence'] = residence;
    // data['date_of_birth'] = date_of_birth;
    return data;
  }
}
