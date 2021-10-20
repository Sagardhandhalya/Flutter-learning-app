import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
}

void initilizeFirebaseMessageService() {
  debugPrint("Handling a background message");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}
