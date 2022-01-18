import 'package:flutter/material.dart';
import 'package:grocery/model/addToCartResponse.dart';
import 'package:grocery/model/cartResponse.dart';
import 'package:grocery/model/personalcarttotal.dar.dart';
import 'package:grocery/model/productResponse.dart';
import 'package:grocery/model/verfityOtp.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/network/api_constant.dart';
import 'package:grocery/screen/custom.dart';
import 'package:grocery/screen/delivery.dart';
import 'package:grocery/screen/orderSucess.dart';
import 'package:grocery/screen/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

List<Personalcart> trails = [];

class cart_screen extends StatefulWidget {
  // final String id;
  // cart_screen(this.id, {Key key}) : super(key: key);

  @override
  _cart_screenState createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  Razorpay _razorpay;
  double callerf = 0;
  double calcc = 0;
  bool counter = true;

  @override
  void initState() {
    // totalamount();
    getvalidationData();

    // TODO: implement initState
    super.initState();

    //razorpay =new Razorpay();

    // getDataFromSharedPrefs();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(total, mobile, email) async {
    print(total);
    var options = {
      'key': 'rzp_test_ACNiLVzWwMtvra',
      'amount': num.parse(total) * 100,
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
    // Provider.of<Orders>(context,listen: false).addOrder(
    //   cart.items.values.toList(),
    //   cart.totalAmount,
    // );
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

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context)=>orderSuccess(Response,orderID),
    //     )
    // );
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  Future<Personalcart> _future;
  Future<Personalcartdetail> _future2;

  // List prod_id;
  var prod_id;
  var product_id;
  String pro_id;
  String name;
  String pro_price;
  String pro_qty;
  String payment_id;
  String pro_image;
  String payment_type;
  String address;
  String status;
  String id;
  String user_id;
  String Response;
  String orderID;
  String Result;
  String total;
  String gst;
  String final_total;
  String mobile;
  String email = "akyadav9155@gmail.com";

  void totalamount() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('user_id');
    user_id = userid;

    Personalcartdetail personalcartdetail =
        await ApiCall.personal_cart_detail(user_id);
    //////
    ///

    Personalcart personnncaarrt = await ApiCall.personal_cart(user_id);

    // var ttt=personnncaarrt.data.

    // for (int i = 0; i < personnncaarrt.data.length; i++) {
    //   setState(() {
    //     calcc += double.parse(personnncaarrt.data[i].price);
    //     // final_total = callerf.toString();
    //   });
    //   print(final_total + "nulllll");
    // }
    // setState(() {
    //   final_total = callerf.toString();
    // });

    // if (personalcartdetail == null) {
    //   print('data not  sent or error');
    // } else {
    //   setState(() {
    //     var tot = personalcartdetail.total.toString();
    //     total = tot;
    //     print(total);
    //     gst = personalcartdetail.gst.toString();
    //     final_total = personalcartdetail.totalPriceWithGst.toString();
    //     print("your total with gst${final_total}");
    //   });
    // }
  }

  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('user_id');

    mobile = sharedPreferences.getString('mobile');
    setState(() {
      user_id = userid;
      _future = ApiCall.personal_cart(user_id);
      _future2 = ApiCall.personal_cart_detail(user_id);
      print(_future);
      print(_future2);
    });

    print(user_id);
  }

  // @override
  // void initState() {
  //   // id = widget.id;
  //   getvalidationData();
  //   print("Hello Akhilesh your id ${user_id} welcome to this world");
  //
  //   super.initState();
  // }

  circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 45,
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            side: BorderSide(color: Colors.black),
                          ),
                          shadows: [
                            const BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.2,
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                        // Consumer<Cart>(
                        //   builder: (_,cart,ch)=>Badge(
                        //     child:ch,
                        //     value: cart.itemCount.toString(),
                        //   ),
                        child: IconButton(
                            color: Colors.grey,
                            iconSize: 30,
                            icon: const Icon(Icons.favorite),
                            tooltip: 'cart',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => wishlist(),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // color: Colors.red,
                        width: 200,
                        height: 45,
                        child: TextFormField(
                          // controller:
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 2),
                            ),
                            hintText: 'Review Basket',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            side: BorderSide(color: Colors.black),
                          ),
                          shadows: [
                            const BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.2,
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                        child: Stack(
                          children: [
                            IconButton(
                                color: Colors.grey,
                                iconSize: 30,
                                icon: const Icon(Icons.shopping_cart),
                                tooltip: 'cart',
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => cart_screen(),
                                  //   ),
                                  // );
                                }),
                            Positioned(
                              right: 8,
                              left: 18,
                              child: new Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: new BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 5,
                                    minHeight: 5,
                                  ),
                                  child: FutureBuilder(
                                      future: _future,
                                      builder: (ctx, snap) {
                                        if (snap.hasData) {
                                          Personalcart model = snap.data;

                                          return Text(
                                            model.data.length.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        } else
                                          return Text('');
                                      })
                                  //  Text(
                                  //   '2',
                                  //   style: TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: 12,
                                  //   ),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                  ),
                            )
                          ],
                        ),
                        //Icon(
                        //   Icons.shopping_cart,
                        //   size: 30,
                        //   color: Colors.grey,
                        // ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Container(
                    //   height: MediaQuery.of(context).size.height,
                    height: 500,
                    child: FutureBuilder(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("Snapshot has all data");
                          Personalcart model = snapshot.data;

                          // model.data.forEach((element) =>
                          //     calcc += double.parse(element.price));

                          //totalamount();
                          // final_total = calcc.toString();

                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: model.data.length,
                              itemBuilder: (ctx, index) {
                                final item = model.data[index];
                                return Dismissible(
                                  key: Key(item.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  // confirmDismiss: (direction){
                                  //
                                  // },

                                  onDismissed: (direction) {
                                    setState(() {
                                      //   total=model.total.toString();
                                      id = model.data[index].id;

                                      ApiCall.personal_cart_remove(id);
                                      model.data.removeAt(index);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'item remove sucessfully')));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        // color: Colors.red,
                                        height: 100,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                // SizedBox(
                                                //   width: 10,
                                                //   height: 70,
                                                //
                                                // ),
                                                Image.network(
                                                  model.data[index].image,
                                                  height: 70,
                                                  width: 90,
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text("Id : "),
                                                        Text(
                                                          model.data[index].id
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                      child: Row(
                                                        children: [
                                                          Text("Qty : "),
                                                          Text(model.data[index]
                                                              .quantity
                                                              .toString()),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      // width: 60,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Rs .',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          ),
                                                          Text(
                                                            model.data[index]
                                                                .price
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Padding(
                                                //   padding:
                                                //   const EdgeInsets.fromLTRB(
                                                //       40, 20, 10, 0),
                                                //   child: Container(
                                                //     width: 100,
                                                //     child: ElevatedButton(
                                                //       onPressed: () async {
                                                //         CartResponse cartResponse =
                                                //         await ApiCall.addTocart(
                                                //           user_id: user_id,
                                                //           product_id: model
                                                //               .product[index]
                                                //               .productId,
                                                //           price: model
                                                //               .product[index].price,
                                                //           quantity: "1",
                                                //         );
                                                //         Scaffold.of(context)
                                                //             .showSnackBar(SnackBar(
                                                //           duration:
                                                //           Duration(seconds: 8),
                                                //           content: Text(
                                                //               "item Added to cart"),
                                                //         ));
                                                //       },
                                                //       child: const Text(
                                                //         'Add',
                                                //       ),
                                                //       style: ButtonStyle(
                                                //           foregroundColor:
                                                //           MaterialStateProperty.all<Color>(
                                                //               Colors.white),
                                                //           backgroundColor:
                                                //           MaterialStateProperty
                                                //               .all<Color>(
                                                //               Colors.red),
                                                //           shape: MaterialStateProperty.all<
                                                //               RoundedRectangleBorder>(
                                                //               RoundedRectangleBorder(
                                                //                   borderRadius:
                                                //                   BorderRadius.zero,
                                                //                   side: BorderSide(color: Colors.red)))),
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ],
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
                // Container(
                //   height: 100,
                //   color: Colors.black12,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Container(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             // Text(calcc.toString()),
                //             // Text('Saved Rs.324${product_id}'),
                //             FutureBuilder(
                //                 future: _future,
                //                 builder: (ctx, snap) {
                //                   if (snap.hasData) {
                //                     double summ = 0;
                //                     Personalcart model = snap.data;
                //                     model.data.forEach((element) {
                //                       summ += double.parse(element.price) *
                //                           double.parse(element.quantity);
                //                     });

                //                     return Text(summ.toString());
                //                   } else
                //                     return Center(
                //                       child: circularProgress(),
                //                     );
                //                 })
                //           ],
                //         ),
                //       ),
                //       ButtonTheme(
                //         minWidth: 200,
                //         height: 35,
                //         buttonColor: Colors.red,
                //         child: RaisedButton(
                //           onPressed: () {
                //             // openCheckout(total, email ,mobile);
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => delivery(
                //                   pro_id,
                //                   name,
                //                   pro_price,
                //                   pro_qty,
                //                   pro_image,
                //                   total,
                //                 ),
                //               ),
                //             );
                //           },
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(3)),
                //           child: Padding(
                //             padding: const EdgeInsets.all(12.0),
                //             child: Text(
                //               'Checkout',
                //               style:
                //                   TextStyle(color: Colors.white, fontSize: 18),
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
         // color: Colors.transparent,
          child: Container(
            height: 100,
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(calcc.toString()),
                      // Text('Saved Rs.324${product_id}'),
                      FutureBuilder(
                          future: _future,
                          builder: (ctx, snap) {
                            if (snap.hasData) {
                              double summ = 0;
                              Personalcart model = snap.data;
                              model.data.forEach((element) {
                                summ += double.parse(element.price) *
                                    double.parse(element.quantity);
                              });

                              return Text(summ.toString());
                            } else
                              return Center(
                                child: circularProgress(),
                              );
                          })
                    ],
                  ),
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 35,
                  buttonColor: Colors.red,
                  child: RaisedButton(
                    onPressed: () {
                      // openCheckout(total, email ,mobile);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => delivery(
                            pro_id,
                            name,
                            pro_price,
                            pro_qty,
                            pro_image,
                            total,
                          ),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Checkout',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
