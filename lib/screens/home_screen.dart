// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_61_notifications/constatns.dart';
import 'package:online_61_notifications/services/notification_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                NotificationServices.showNotification(1, "Good afternon", "Have a nice day");
              }, 
              child: Text("Show notification"),
            ),
            TextButton(
              onPressed: (){
                NotificationServices.showPeriodicNotification(waterReminderId, "Drink water", "You should drink 2 liter of water");
              }, 
              child: Text("Water reminder"),
            )
          ],
        ),
      ),
    );
  }
}