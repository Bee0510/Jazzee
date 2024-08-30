import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<String> getToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();

  print("FCM Token: $token");
  await messaging.subscribeToTopic("your_topic_name");

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    print("New FCM Token: $newToken");
  });
  return token!;
}

class TokenProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  TokenProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    _token = await messaging.getToken();
    notifyListeners();

    messaging.onTokenRefresh.listen((newToken) {
      _token = newToken;
      notifyListeners();
    });
  }

  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }
}
