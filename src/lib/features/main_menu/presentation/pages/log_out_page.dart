
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoodar/features/main_menu/presentation/pages/main_menu_page.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/bottom_navigation.dart';

class LogOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenuPage()),
    ),
      child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child:Text(
            "Logged out",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: 2,
      ),
    )
  );
  }
}