import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/model/placeOrderModel.dart';
import 'package:grocery/model/userOrderModel.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/order_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class order extends StatefulWidget {
  @override
  _orderState createState() => _orderState();
}

class _orderState extends State<order> {
  Future<PlaceOrderResponce> _future;
  String id;
  String user_id;
  String Response;
  String orderID;
  String mobile;

  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('user_id');
    mobile = sharedPreferences.getString('mobile');

    ///
    // UserOrder usrOrdr = await ApiCall.personal_order(userid);
    // print(usrOrdr.data);
    // print(usrOrdr.status);
    // print(usrOrdr.message);

    setState(() {
      user_id = userid;

      _future = ApiCall.personal_order(user_id);
    });
    print(user_id);
    print('hell');
    print(_future);
  }

  circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    getvalidationData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF48221),
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        // actions: [
        //   Padding(
        //       padding: EdgeInsets.only(right: 20.0),
        //       child: GestureDetector(
        //         onTap: () {},
        //         child: Icon(
        //           Icons.search,
        //           size: 26.0,
        //         ),
        //       )),
        //   Padding(
        //       padding: EdgeInsets.only(right: 20.0),
        //       child: GestureDetector(
        //         onTap: () {},
        //         child: Icon(Icons.mic),
        //       )),
        //   Padding(
        //       padding: EdgeInsets.only(right: 20.0),
        //       child: GestureDetector(
        //         onTap: () {},
        //         child: Icon(Icons.shopping_cart_rounded),
        //       )),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("Snapshot has data");
                PlaceOrderResponce model = snapshot.data;

                print(model.data.length);

                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: model.data.length,
                    itemBuilder: (ctx, index) {
                      final item = model.data[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contx) => OrderDetailsScreen(
                                        address: item.address.toString(),
                                        price: item.price.toString(),
                                        name: item.productName.toString(),
                                        image: item.image.toString(),
                                        orderId: item.paymentId.toString(),
                                        quantity: item.quantity.toString(),
                                      )));
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: ListTile(
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: 100, minHeight: 100),
                                  child: Image.network(
                                    model.data[index].image,
                                    //'https://images.unsplash.com/photo-1559563458-527698bf5295?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                title: Text(
                                  model.data[index].productName.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('Delivered 28-Jul-2021'),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                print(snapshot.error.toString());
                return circularProgress();
                //Text(snapshot.error.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}
