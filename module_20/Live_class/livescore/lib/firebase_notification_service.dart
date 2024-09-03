import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseNotificationService._();
  static final FirebaseNotificationService instance =
      FirebaseNotificationService._();
  Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
