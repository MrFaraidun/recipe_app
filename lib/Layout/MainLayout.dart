import 'package:flutter/material.dart';
import 'package:recipe_app/pages/Home_Page.dart';
import 'package:recipe_app/pages/Notification/NotificationPage.dart';
import 'package:recipe_app/pages/ProfilePage.dart';
import 'package:recipe_app/pages/upload/upload_step1.dart';
import 'package:recipe_app/widgets/custom_bottom_nav.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DefaultTabController(length: 2, child: const HomePage()),
    const UploadStep1(),
    const SizedBox(), // scan placeholder
    const NotificationPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, '/scan');
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
