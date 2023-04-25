/// The `UserModel` class represents a user with various attributes and includes methods for creating
/// instances from JSON and Firestore data, as well as converting user data to JSON format.
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String username;
  late String email;
  late String yearGroup;
  late String bestFood;
  late String bestMovie;
  late String userId;
  late String major;
  late String avatarUrl;
  late String residence;
  late bool isOnline;
  late DateTime dateOfBirth; 

/// constructor for the `UserModel` class that initializes the corresponding instance variables with theirvalues. 
  UserModel({
    required this.username,
    required this.email,
    required this.userId,
    required this.major,
    required this.yearGroup,
    required this.bestFood,
    required this.bestMovie,
    required this.residence,
    required this.avatarUrl,
    required this.dateOfBirth, 
  });

  /// a factory constructor that takes a JSON object as input and creates
  /// a new instance of the `UserModel` class with the corresponding instance variables initialized with
  /// the values from the JSON object. 
  UserModel.fromJson(json) {
    username = json['first_name'];
    email = json['email_or_phone'];
    userId = json['user_id'];
    major = json['major'];
    yearGroup = json['year_group'];
    bestFood = json['best_food'];
    bestMovie = json['best_movie'];
    residence = json['residence'];
    avatarUrl = json['avatar_url'];
    dateOfBirth = DateTime.parse(json['date_of_birth']); // Parse the new field from JSON
  }


/// This is a constructor for the `UserModel` class that takes a `DocumentSnapshot` object as input and
/// creates a new instance of the `UserModel` class with the corresponding instance variables
/// initialized with the values from the `DocumentSnapshot` object. 
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    username = data['first_name'];
    email = data['email_or_phone'];
    userId = data['user_id'];
    major = data['major'];
    yearGroup = data['year_group'];
    bestFood = data['best_food'];
    bestMovie = data['best_movie'];
    residence = data['residence'];
    avatarUrl = data['avatar_url'];
    dateOfBirth = data['date_of_birth'].toDate(); // Convert the new field from Firestore Timestamp to DateTime
  }


/// This function converts user data to a JSON format 
/// Returns:
///   A Map<String, dynamic> object containing the user's information in key-value pairs.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = username;
    data['email_or_phone'] = email;
    data['major'] = major;
    data['year_group'] = yearGroup;
    data['best_food'] = bestFood;
    data['user_id'] = userId;
    data['avatar_url'] = avatarUrl;
    data['best_movie'] = bestMovie;
    data['residence'] = residence;
    data['date_of_birth'] = Timestamp.fromDate(dateOfBirth); // Convert the new field to Firestore Timestamp
    return data;
  }
}
