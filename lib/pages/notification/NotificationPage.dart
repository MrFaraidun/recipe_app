import 'package:flutter/material.dart';
import 'package:recipe_app/pages/Notification/GroupedLikeNotification.dart';
import 'package:recipe_app/pages/Notification/NotificationItem.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          const Text(
            'New',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          NotificationItem(
            name: 'Dean Winchester',
            action: 'is now following you',
            time: '1h',
            imagePath: 'assets/pancake.png',
            showFollowButton: true,
            isFollowed: false,
          ),
          const SizedBox(height: 16),
          const Text(
            'Today',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          GroupedLikeNotification(
            firstUserName: 'John Steve',
            secondUserName: 'Sam Winchester',
            firstUserImage: 'assets/pancake.png',
            secondUserImage: 'assets/pancake.png',
            action: 'liked your recipe',
            time: '20 min',
            thumbnailPath: 'assets/pancake.png',
          ),
          NotificationItem(
            name: 'Dean Winchester',
            action: 'is now following you',
            time: '2h',
            imagePath: 'assets/pancake.png',
            showFollowButton: true,
            isFollowed: true,
          ),
          const SizedBox(height: 16),
          const Text(
            'Yesterday',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          NotificationItem(
            name: 'Dean Winchester',
            action: 'is now following you',
            time: '1d',
            imagePath: 'assets/pancake.png',
            showFollowButton: true,
            isFollowed: false,
          ),
        ],
      ),
    );
  }
}
