// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';

class NotificationServices{
  static FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  static NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails("channel 1", "channel name", priority: Priority.high),
      iOS: DarwinNotificationDetails(
        presentSound: true,
        presentBadge: true,
      ),
    );

  static Future<void> init() async{ 
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitializationSettings = DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await notificationsPlugin.initialize(initializationSettings);
    await notificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  static void showNotification(int id, String title, String body){
    notificationsPlugin.show(id, title, body, notificationDetails);
  }

  static void showPeriodicNotification(int id , String title, String body){
    notificationsPlugin.periodicallyShow(id, title, body, RepeatInterval.daily, notificationDetails);
  }

  static void showScheduleNotification(int id , String title, String body) async{
    var now = TZDateTime.now(local);
    await notificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    TZDateTime(local, now.year, now.month+1, now.day),
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  } 
}