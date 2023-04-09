// ignore_for_file: non_constant_identifier_names

class UserModel {
  String username;
  String email;
  String year_group;
  String best_food;
  String user_id;
  String major;
  String avatar_url;
  bool isOnline;

  UserModel(
      {this.username,
      this.email,
      this.user_id,
      this.major,
      this.year_group,
      this.best_food,
      this.avatar_url});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['first_name'];
    email = json['email_or_phone'];
    user_id = json['user_id'];
    major = json['major'];
    year_group = json['year_group'];
    best_food = json['best_food'];
    avatar_url = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = username;
    data['email_or_phone'] = email;
    data['major'] = major;
    data['year_group'] = year_group;
    data['best_food'] = best_food;
    data['user_id'] = user_id;
    data['avatar_url'] = avatar_url;
    return data;
  }
}
