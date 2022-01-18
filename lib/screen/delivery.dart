import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grocery/model/add_address.dart';
import 'package:grocery/model/cartResponse.dart';
import 'package:grocery/model/personal_cart_gsst.dart';
import 'package:grocery/model/userOrderModel.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/address.dart';
import 'package:grocery/screen/custom.dart';
import 'package:grocery/screen/home_screen.dar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class delivery extends StatefulWidget {
  final String pro_id;
  final String name;
  final String pro_price;
  final String pro_qty;
  final String pro_image;
  String total;
  delivery(this.name, this.pro_id, this.pro_price, this.pro_qty, this.pro_image,
      this.total,
      {Key key})
      : super(key: key);

  @override
  _deliveryState createState() => _deliveryState();
}

class _deliveryState extends State<delivery> {
  Future<AddAddress> _future;
  Future<PersonalCartGst> _future2;
  String user_id;
  String pro_id = "12345";
  String name = "ankit";
  String pro_price = "100";
  String pro_qty = "5";
  String payment_id = "1234";
  String pro_image = "akhilesh.jpg";
  String payment_type = "fruits";
  String address = "buxar";
  String status = "active";

  String finalAddress = '';

  Razorpay _razorpay;

  @override
  void initState() {
    getvalidationData();

    // TODO: implement initState
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> _addOrder(String payId, String ordId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('user_id');
    mobile = sharedPreferences.getString('mobile');
    setState(() {
      user_id = userid;

      print("Hello ravan your id ${user_id} welcome to this world");
      ApiCall.placeOrder(
          user_id: user_id,
          adresss: finalAddress,
          payment_id: payId,
          payment_type: 'RazorPay');
    });
    print(user_id);
    // Future.delayed(Duration(seconds: 2), () {
    //   setState(() {
    //     ApiCall.personal_cart_all_delete(user_id);
    //   });
    // });
    Timer(Duration(seconds: 1), () {
      ApiCall.personal_cart_all_delete(user_id);
    });
  }

  void openCheckout(String mobile, String email) async {
    var options = {
      'key': 'rzp_test_ACNiLVzWwMtvra',
      'amount': num.parse(widget.total) * 100,
      //'amount': total,
      //'name': 'Acme Corp.',
      // 'description': 'Fine T-Shirt',
      'prefill': {'contact': email, 'email': mobile},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Response = response.paymentId;
    orderID = response.orderId;
    _addOrder(response.paymentId, response.orderId);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (builder) => home()), (route) => false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Order Successful",
            descriptions:
                "You will be receiving a confirmation email with order details",
            text: "OK",
          );
        });

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 30);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 200);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName,
    );
  }

  String id;

  String Response;
  String orderID;

  // String total = ;
  String mobile;
  String email = "akyadav9155@gmail.com";

  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('user_id');
    mobile = sharedPreferences.getString('mobile');
    Personalcart PrsCart = await ApiCall.personal_cart(userid);

    setState(() {
      user_id = userid;
      print("Hello ravan your id ${user_id} welcome to this world");
      print(PrsCart.data);
      print(PrsCart.responce);
      print(PrsCart.data.length);
      print(PrsCart.data[0].id);
      print(PrsCart.data[0].image);
      print(PrsCart.data[0].price);
      print(PrsCart.data[0].productId);
      print(PrsCart.data[0].quantity);

      _future = ApiCall.personal_address(user_id);
      _future2 = ApiCall.personal_cart_gst_price(user_id);
    });
    print(user_id);
  }

  circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: AppBar(
      //   title: Text('Delivery'),
      //   elevation: 0.0,
      // ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.black38,
                          blurRadius: 10),
                      BoxShadow(
                          offset: Offset(-10, -10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 20)
                    ]),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Colors.grey,
                            )),
                        SizedBox(
                          width: 45,
                        ),
                        Text('Delivery Options',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                shadows: [
                                  Shadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: Offset(6, 6),
                                      blurRadius: 10),
                                ]))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 270,
                    width: 400,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.black38,
                          blurRadius: 10),
                      BoxShadow(
                          offset: Offset(-10, -10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 20)
                    ]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'ADDRESS',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Divider(
                          thickness: 2.0,
                          color: Colors.grey.shade200,
                        ),
                        Container(
                          // width: 200,

                          height: 160,
                          child: SingleChildScrollView(
                            child: FutureBuilder(
                              future: _future,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  print("Snapshot has data welcome ravan");
                                  AddAddress model = snapshot.data;
                                  if (model.data.length > 0) {
                                    finalAddress = 'name: ' +
                                        model.data.last.name +
                                        ' House No: ' +
                                        model.data.last.houseNo +
                                        ' Pincode: ' +
                                        model.data.last.pinCode +
                                        ' Road no: ' +
                                        model.data.last.roadNo +
                                        ' City: ' +
                                        model.data.last.city +
                                        ' State: ' +
                                        model.data.last.state;
                                  }
                                   if (model.data.length == 0)
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width -
                                          10,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text('Name : XXXX'), 
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Mob No : XXXX')
                                        ],
                                      ),
                                    );
                                  return SingleChildScrollView(
                                    child: ListView.builder(
                                        //scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        // scrollDirection: Axis.vertical,
                                        itemCount: model.data.length,
                                        itemBuilder: (ctx, index) {
                                          //  print(model.data[index].name);

                                          return SingleChildScrollView(
                                            child: Container(
                                              // width: 200,
                                              // height: 120,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25),
                                                    child: Row(
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              model.data.last
                                                                  .name,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                        SizedBox(
                                                          width: 170,
                                                        ),
                                                        Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              height: 20,
                                                              width: 45,
                                                              child: Text(
                                                                ' HOME ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .green)),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          model
                                                              .data.last.roadNo,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          model.data.last
                                                              .houseNo,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              model.data.last
                                                                  .city,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              model.data.last
                                                                  .pinCode,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          model.data.last.state,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 25,
                                                    ),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          'Mobile: ${model.data.last.phone}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                } else {
                                  print(snapshot.error.toString());
                                  return circularProgress();
                                  //Text(snapshot.error.toString());
                                }
                              },
                              // child: Container(
                              //   child: Column(
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.only(left: 25),
                              //         child: Row(
                              //           children: [
                              //             Align(
                              //                 alignment: Alignment.topLeft,
                              //                 child: Text('JASSI RANA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                              //             SizedBox(width: 170,),
                              //             Align(
                              //                 alignment: Alignment.topRight,
                              //                 child: Container(
                              //                   height: 20,
                              //                   width: 45,
                              //                   child: Text(' HOME ', style: TextStyle(color: Colors.black12),),
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all(color: Colors.green)
                              //                   ),
                              //                 )
                              //             ),
                              //           ],
                              //
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(left: 25),
                              //         child: Align(
                              //             alignment: Alignment.topLeft,
                              //             child: Text('Near Central Park, Lucknow, UP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(left: 25),
                              //         child: Align(
                              //             alignment: Alignment.topLeft,
                              //             child: Text('Agdfhe Uidfgjkgf', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(left: 25),
                              //         child: Align(
                              //             alignment: Alignment.topLeft,
                              //             child: Text('AFGDKJVD', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(left: 25),
                              //         child: Align(
                              //             alignment: Alignment.topLeft,
                              //             child: Text('Whxhfgdz, 2XX895', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(left: 25, top: 10),
                              //         child: Align(
                              //             alignment: Alignment.topLeft,
                              //             child: Text('Mobile: 789645XXX', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 35,
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddAccount(
                                      widget.name,
                                      widget.pro_id,
                                      widget.pro_price,
                                      widget.pro_qty,
                                      widget.pro_image,
                                      widget.total),
                                ),
                              );
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('CHANGE OR ADD ADDRESS')),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.black38,
                          blurRadius: 10),
                      BoxShadow(
                          offset: Offset(-10, -10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 20)
                    ]),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.wallet_giftcard_rounded)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Have a Gift Card?',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          'Apply',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    width: 400,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.black38,
                          blurRadius: 10),
                      BoxShadow(
                          offset: Offset(-10, -10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 20)
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 20),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Item delivered by 12 July, 20XX')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 400,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.black26,
                          blurRadius: 10),
                      BoxShadow(
                          offset: Offset(-10, -10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 20)
                    ]),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.access_time)),
                        Text('Tomorrow 12:00PM - 02:00 PM')
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 32,
                    width: 400,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.black26,
                          blurRadius: 10),
                      BoxShadow(
                          offset: Offset(-10, -10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 20)
                    ]),
                    child: Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.money)),
                        Text('Cart Total'),
                        SizedBox(
                          width: 20,
                        ),
                        // Text('5000')
                        FutureBuilder(
                            future: _future2,
                            builder: (ctx, snap) {
                              if (snap.hasData) {
                                PersonalCartGst model = snap.data;
                                widget.total =
                                    model.totalPriceWithGst.toString();
                                print(widget.total);
                                print('total');

                                return Text(model.totalPriceWithGst
                                    .toString()); //model.total.toString());
                              } else
                                return Center(
                                  child: circularProgress(),
                                );
                            })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      // _addOrder();
                      if (finalAddress == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please Enter a Address!')));
                      } else {
                        openCheckout(email, mobile);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      child: Center(
                          child: Text(
                        'PROCEED TO PAY',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
