import 'package:flutter/material.dart';
import 'package:grocery/screen/custom.dart';

class orderSuccess extends StatefulWidget {
  const orderSuccess(String response, String orderID, {Key key})
      : super(key: key);

  @override
  _orderSuccessState createState() => _orderSuccessState();
}

class _orderSuccessState extends State<orderSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place your Order'),
        elevation: 0.0,
      ),
      body: Center(
        child: TextButton(

          onPressed: (){

          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
