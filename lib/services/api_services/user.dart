import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hub_client/services/base_service.dart';
import 'package:hub_client/utils/firebase_collections.dart';

/// The UserService class provides methods to get the current authenticated user's UID and update their
/// online status.
class UserService extends Service {
  //get the authenticated uis
  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  setUserStatus(bool isOnline) {
    var user = firebaseAuth.currentUser;
    if (user != null) {
      usersRef
          .doc(user.uid)
          .update({'isOnline': isOnline, 'lastSeen': Timestamp.now()});
    }
  }
}
