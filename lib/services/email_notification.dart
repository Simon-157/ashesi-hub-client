import 'package:cloud_functions/cloud_functions.dart';

final FirebaseFunctions functions = FirebaseFunctions.instance;

Future<void> sendNotificationEmail() async {
  HttpsCallable callable = functions.httpsCallable('sendNotificationEmail');
  try {
    await callable.call(<String, dynamic>{});
    print('Email sent');
  } catch (e) {
    print('Error: $e');
  }
}
