import 'package:flutter/material.dart';
import 'package:netflixclone/Screens/homeActivty.dart';
import 'package:netflixclone/Screens/newandmoreActivity.dart';
import 'package:netflixclone/Screens/searchActivity.dart';
import 'package:netflixclone/Screens/searchScreen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.photo_library_outlined),
                text: "New & Hot",
              )
            ],
            unselectedLabelColor: Color(0xFF999999),
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
          ),
          body: TabBarView(
              children: [HomeScreen(), SearcheScreen(), NewandMoreScreen()]),
        ));
  }
}
