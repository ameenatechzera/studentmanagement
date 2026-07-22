import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/attendence/presentation/screens/attendence_screen.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/screens/alldiary_screen.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/home_screen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';
import 'package:studentmanagement/main.dart'; // wherever navigatorKey is defined

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.messageId}");
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static String? pendingType;
  static String? pendingDiaryId;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  /// Call this BEFORE runApp(), but it no longer blocks on network calls.
  static Future<void> init() async {
    await _requestPermission();
    await _setupLocalNotifications();

    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Fire-and-forget: do NOT await this, it makes an HTTP call and
    // was previously delaying runApp() (and therefore the Navigator).
    _getToken();

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print('📬 Cold start via notification: ${initialMessage.data}');
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
        print('Notification tapped (local): ${details.payload}');
        if (details.payload != null && details.payload!.isNotEmpty) {
          try {
            final Map<String, dynamic> data = jsonDecode(details.payload!);
            final message = RemoteMessage(data: data);
            _handleMessage(message);
          } catch (e) {
            print('Failed to parse notification payload: $e');
          }
        }
      },
    );

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
    try {
      final token = await _messaging.getToken();
      print('FCM Token: $token');

      final pref = SharedPreferenceHelper();
      final dbName = await pref.getDatabaseName();
      final loginToken = await pref.getToken();
      final baseUrl = await pref.getBaseUrl();

      if (token != null && loginToken != null && dbName != null && baseUrl != null) {
        await sendTokenToServer(token, loginToken, dbName, baseUrl);
      }
    } catch (e) {
      print('Error in _getToken: $e');
    }
  }

  static Future<void> sendTokenToServer(
      String token,
      String loginToken,
      String dbName,
      String baseUrl,
      ) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + 'save-fcm-token'),
        headers: {
          "Authorization": "Bearer $loginToken",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-Database-Name": dbName,
        },
        body: jsonEncode({"fcm_token": token, "Admno": AppData.admissionNo}),
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
        payload: jsonEncode(message.data),
      );
    }
  }

  static void _onMessageOpenedApp(RemoteMessage message) {
    print('📬 Opened from background: ${message.data}');
    _handleMessage(message);
  }

  /// Single source of truth for handling a message's navigation intent.
  static void _handleMessage(RemoteMessage message) {
    final data = message.data;
    final type = data['type']?.toString().trim();
    final diaryId = data['diary_id']?.toString();

    print('📬 _handleMessage → type: $type, diaryId: $diaryId');

    if (type == 'diary') {
      pendingType = type;
      pendingDiaryId = diaryId;
      // Try right away — covers foreground/warm-resume cases where
      // the navigator is already mounted.
      tryConsumeQueue();
    }
    // Add more `else if (type == 'attendance') { ... }` cases here later.
  }

  /// Call this:
  /// 1. immediately after setting pendingType (above)
  /// 2. from HomeScreen.initState via postFrameCallback
  /// 3. from a WidgetsBindingObserver.didChangeAppLifecycleState(resumed) — see main.dart
  static void tryConsumeQueue() {
    print('🔁 tryConsumeQueue → pendingType: $pendingType, navReady: ${navigatorKey.currentState != null}');

    if (pendingType == null) return;

    if (navigatorKey.currentState != null) {
      if (pendingType == 'diary') {
        navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (_) => AllClassDiaryScreen()),
        );
      }
      else if (pendingType == 'attendance') {
        navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (_) => AttendenceScreen()),
        );
         }
      else{
        navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }

      print('✅ Navigated for pendingType: $pendingType');
      pendingType = null;
      pendingDiaryId = null;
    } else {
      // Navigator not ready yet — retry shortly instead of giving up.
      Future.delayed(const Duration(milliseconds: 300), tryConsumeQueue);
    }
  }
}