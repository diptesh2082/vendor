import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future getDevicetoken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      print(token);
      return token;
    } catch (e) {
      print(e);
    }
  }
}
