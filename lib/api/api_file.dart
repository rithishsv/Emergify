import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _FirebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _FirebaseMessaging.requestPermission();
    final fCMToken = await _FirebaseMessaging.getToken();
    print('Token: $fCMToken');
  }
}