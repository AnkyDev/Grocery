import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  String name;
  String image;
  String price;
  String address;
  String quantity;
  String orderId;
  OrderDetailsScreen(
      {this.name,
      this.address,
      this.image,
      this.price,
      this.quantity,
      this.orderId});

  @override
  Widget build(BuildContext context) {
    int lastPrice = int.parse(price) * int.parse(quantity);
    // print(price);
    // print(price);
    print(price);
    print(quantity);
    print(orderId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(8),
            child: Center(
              child: ClipRRect(
                child: Image.network(
                  image,
                  width: 250,
                  height: 300,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(7),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Date',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('28 aug 2020',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order #',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(orderId,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order Total',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('${lastPrice} (${quantity} item)',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
