import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:studentmanagement/services/shared_preference_helper.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.messageId}");
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  static Future<void> init() async {
    await _requestPermission();
    await _setupLocalNotifications();
    await _getToken();


    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  static Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permission: ${settings.authorizationStatus}');
  }

  static Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    await _localNotifications.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: (details) {
        print('Notification tapped: ${details.payload}');
      },
    );

    // ✅ Fixed: added missing < before AndroidFlutterLocalNotificationsPlugin
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> _getToken() async {
    final token = await _messaging.getToken();
    print('FCM Token: $token');
    // ✅ Send token to Laravel backend
    final pref = SharedPreferenceHelper();

    final dbName = await pref.getDatabaseName();
    final loginToken = await pref.getToken();
    final baseUrl = await pref.getBaseUrl();
    print('dbName $dbName');
    print('baseUrl $baseUrl');
    print('loginToken $loginToken');

    await sendTokenToServer(token!,loginToken!,dbName!,baseUrl!);
  }
  static Future<void> sendTokenToServer(
      String token,
      String loginToken,
      String dbName,
      String baseUrl
      ) async {
    try {
      final response = await http.post(
        Uri.parse(
          baseUrl+"save-fcm-token"),
        headers: {
          "Authorization": "Bearer $loginToken",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-Database-Name":
          dbName
        },
        body: jsonEncode({
          "fcm_token": token,
        }),
      );


      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    } catch (e) {
      print("Error sending token: $e");
    }
  }
  static void _onForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null && Platform.isAndroid) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            icon: '@mipmap/ic_launcher',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  static void _onMessageOpenedApp(RemoteMessage message) {
    print('Opened from background: ${message.data}');
    _handleMessage(message);
  }

  static void _handleMessage(RemoteMessage message) {
    print('Handle message: ${message.data}');
  }
}