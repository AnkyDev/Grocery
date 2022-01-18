import 'package:flutter/material.dart';
import 'package:grocery/screen/product_screen.dart';

class category extends StatefulWidget {
  const category({Key key}) : super(key: key);

  @override
  _categoryState createState() => _categoryState();
}

class _categoryState extends State<category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: DrawerHeader(
                child: Text(
              "Categories",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
            )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => product_screen('6')));
            },
            child: ListTile(
              title: Text(
                "Fruits and Vegitables",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_downward_sharp),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => product_screen('8')));
            },
            child: ListTile(
              title: Text(
                "Foodgrains, Oil & Masala",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_downward_sharp),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => product_screen('3')));
            },
            child: ListTile(
              title: Text(
                "Bakery, Cakes and Dairy",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_downward_sharp),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => product_screen('4')));
            },
            child: ListTile(
              title: Text(
                "Beverages",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_downward_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
