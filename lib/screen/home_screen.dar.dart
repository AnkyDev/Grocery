import 'package:flutter/material.dart';
import 'package:grocery/screen/category.dart';
import 'package:grocery/screen/home.dart';
import 'package:grocery/screen/order.dart';
import 'package:grocery/screen/profile.dart';
import 'package:grocery/screen/wallet.dart';

class home extends StatefulWidget {
  const home({Key key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int page = 0;

  List pageoptions = [
    HomeScreen(),
    category(),
    order(),
    profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageoptions[page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        fixedColor: Colors.grey.shade700,
        backgroundColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        // new
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey.shade700,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: Colors.grey.shade700,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: Colors.grey.shade800,
              ),
              label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.grey.shade800,
              ),
              label: 'Profile')
        ],
      ),
    );
  }
}
