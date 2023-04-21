import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hub_client/services/api_services/update_profile.dart';
import 'package:hub_client/services/auth/firebase_auth.dart';

class EditProfileViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  File? image;
  String? imgLink;
  late String year_group;
  late String best_food;
  late String best_movie;
  // String? user_id;
  late String major;
  late String residence;
  late String avatar_url;
  late bool isOnline;

  setYearGroup(String year) {
    year_group = year;
    print(year);
    notifyListeners();
  }

  setBestFood(String food) {
    best_food = food;
    notifyListeners();
  }

  setBestMovie(String movie) {
    best_movie = movie;
    notifyListeners();
  }

  setResidence(String resid) {
    residence = resid;
    notifyListeners();
  }

  setMajor(String course) {
    major = course;
    print(major);
    notifyListeners();
  }

  

  setImage(String user) {
    // imgLink = user.avatar_url;
  }

  editProfile(BuildContext context) async {
    FormState form = formKey.currentState!;
    final Map<String, dynamic> data = <String, dynamic>{};
    data['major'] = major;
    data['year_group'] = year_group;
    data['best_food'] = best_food;
    data['best_movie'] = best_movie;
    data['residence'] = residence;

    // data['avatar_url'] = avatar_url;
    // data['residence'] = avatar_url;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar(
          'Please fix the errors in red before submitting.', context);
    } else {
      try {
        loading = true;
        notifyListeners();

        var status = UpdateProfileService.updateProfile(data, uid);
        Navigator.pop(context);
        showInSnackBar('Profile updated', context);
        print("updated");
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  pickImage({bool camera = false, BuildContext? context}) async {}

  clear() {
    // image = null;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
