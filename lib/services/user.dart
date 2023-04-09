import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hub_client/services/base_service.dart';
import 'package:hub_client/utils/firebase_collections.dart';

class UserService extends Service {
  //get the authenticated uis
  String currentUid() {
    return firebaseAuth.currentUser.uid;
  }

//tells when the user is online or not and updates the last seen for the messages
  setUserStatus(bool isOnline) {
    var user = firebaseAuth.currentUser;
    if (user != null) {
      usersRef
          .doc(user.uid)
          .update({'isOnline': isOnline, 'lastSeen': Timestamp.now()});
    }
  }
}
