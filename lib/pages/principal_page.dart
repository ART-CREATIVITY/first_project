import 'dart:io';

import 'package:first_project/dao/taxpayer_dao.dart';
import 'package:first_project/entities/taxpayer.dart';
import 'package:first_project/pages/profile_page.dart';
import 'package:first_project/pages/taxpayers_page.dart';
import 'package:first_project/web_service/taxpayer_web_service.dart';
import 'package:first_project/web_service/web_service.dart';
import 'package:flutter/material.dart';

import 'edit_taxpayer_page.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {


  int _currentPageIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          TaxpayersPage(),
          ProfilePage()
        ],
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Contribuables"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil"
          )
        ],
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            _pageController.jumpToPage(_currentPageIndex);
          });
        },
        currentIndex: _currentPageIndex,
      ),
    );
  }


}
