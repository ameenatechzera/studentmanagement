// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
//
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Background message: ${message.messageId}");
// }
//
// class NotificationService {
//   static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin _localNotifications =
//   FlutterLocalNotificationsPlugin();
//
//   static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     importance: Importance.high,
//   );
//
//   static Future<void> init() async {
//     await _requestPermission();
//     await _setupLocalNotifications();
//     await _getToken();
//
//
//     FirebaseMessaging.onMessage.listen(_onForegroundMessage);
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//     FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
//
//     final initialMessage = await _messaging.getInitialMessage();
//     if (initialMessage != null) {
//       _handleMessage(initialMessage);
//     }
//   }
//
//   static Future<void> _requestPermission() async {
//     final settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     print('Permission: ${settings.authorizationStatus}');
//   }
//
//   static Future<void> _setupLocalNotifications() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = DarwinInitializationSettings();
//
//     await _localNotifications.initialize(
//       const InitializationSettings(
//         android: androidSettings,
//         iOS: iosSettings,
//       ),
//       onDidReceiveNotificationResponse: (details) {
//         print('Notification tapped: ${details.payload}');
//       },
//     );
//
//     // ✅ Fixed: added missing < before AndroidFlutterLocalNotificationsPlugin
//     await _localNotifications
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_channel);
//
//     await _messaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   static Future<void> _getToken() async {
//     final token = await _messaging.getToken();
//     print('FCM Token: $token');
//     // ✅ Send token to Laravel backend
//     await sendTokenToServer(token!,'');
//   }
//   static Future<void> sendTokenToServer(
//       String token,
//       String loginToken,
//       ) async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//             "https://online.cristaledu.com/Api/public/api/save-fcm-token"),
//         headers: {
//           "Authorization": "Bearer 720|vR6MA7hBfBTSM81jUsofmgSy1udRNKCJ9yAhStX925f0cb34",
//           "Content-Type": "application/json",
//           "Accept": "application/json",
//           "X-Database-Name":
//           "eyJpdiI6InBXZkt2bXZBOUsySDNEdm02YmltRXc9PSIsInZhbHVlIjoiTVNjZGl4d2hmdjZIWUVRR2NOeWE4RDVURnlrNi9WMkZRSDNpcEFvb0Vucz0iLCJtYWMiOiIwYmVjMjg3YWRmNTA4YjJiNDZjMTYwMjg2YmU2ZDg4NmQxMDMyM2IyY2E4ZTA1YzBlMjlhOTI5NGI5NTIxZmY1IiwidGFnIjoiIn0==",
//         },
//         body: jsonEncode({
//           "fcm_token": token,
//         }),
//       );
//
//
//       print("Status Code: ${response.statusCode}");
//       print("Response Body: ${response.body}");
//     } catch (e) {
//       print("Error sending token: $e");
//     }
//   }
//   static void _onForegroundMessage(RemoteMessage message) {
//     final notification = message.notification;
//     final android = message.notification?.android;
//
//     if (notification != null && android != null && Platform.isAndroid) {
//       _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _channel.id,
//             _channel.name,
//             icon: '@mipmap/ic_launcher',
//             importance: Importance.high,
//             priority: Priority.high,
//           ),
//         ),
//         payload: message.data.toString(),
//       );
//     }
//   }
//
//   static void _onMessageOpenedApp(RemoteMessage message) {
//     print('Opened from background: ${message.data}');
//     _handleMessage(message);
//   }
//
//   static void _handleMessage(RemoteMessage message) {
//     print('Handle message: ${message.data}');
//   }
// }