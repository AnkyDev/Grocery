import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class Save extends StatefulWidget {
  final String value;
  final String val1;
  final String val2;
  final String val3;
  final String val4;
  final String val5;
  final String val6;
  Save(
      {Key key,
      this.value,
      this.val1,
      this.val2,
      this.val3,
      this.val4,
      this.val5,
      this.val6})
      : super(key: key);
  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<Save> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Address'),
        backgroundColor: Colors.black,
      ),
      //Text('${widget.value}, ${widget.app}'),
      body: Stack(
        children: [
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          SizedBox(
            height: 280,
          ),
          TextButton.icon(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (builder) => AddAccount()));
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Edit your Addresses',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Card(
                color: Colors.white,
                elevation: 6.0,
                margin: EdgeInsets.only(right: 15.0, left: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      title: Text(
                        'My Address',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70.0, right: 10),
                      child: Text(
                        '${widget.value}, ${widget.val1}, ${widget.val2}, ${widget.val3}, ${widget.val4}, ${widget.val5}, ${widget.val6} ',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFFFF0000);
    
    Path path = Path()
      ..relativeLineTo(0, 240)
      ..quadraticBezierTo(size.width / 2, 10.0, size.width, 240)
      ..relativeLineTo(0, -400)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
