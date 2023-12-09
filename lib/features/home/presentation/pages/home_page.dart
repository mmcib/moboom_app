import 'package:flutter/material.dart';
import 'package:moboom_app/core/extensions/string_extensions.dart';
import 'package:moboom_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:moboom_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:moboom_app/features/comments/presentation/pages/comments_page.dart';
import 'package:moboom_app/features/photos/presentation/pages/photos_page.dart';
import 'package:moboom_app/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _tabOptions = [
    PhotosPage(),
    CommentsPage(),
    SignUpPage(),
    SignInPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _tabOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: S.of(context).photos.capitalize(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: S.of(context).comments.capitalize(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'SignUp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'SignIn',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
