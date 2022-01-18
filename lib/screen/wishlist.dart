import 'package:flutter/material.dart';
import 'package:grocery/model/cartResponse.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/cart.dart';
import 'package:grocery/screen/order_details.dart';
import 'package:grocery/screen/wishlist_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlidableAction { order, wishlist, share, delete }

class wishlist extends StatefulWidget {
  const wishlist({Key key}) : super(key: key);

  @override
  _wishlistState createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {
  Future<Personalcart> _future;
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
    setState(() {
      user_id = userid;
      _future = ApiCall.personal_wishlist(user_id);
    });
    print(user_id);
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => wishlist(),
                              //   ),
                              // );
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
                            hintText: 'Wishlist',
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
                            icon: const Icon(Icons.shopping_cart),
                            tooltip: 'cart',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => cart_screen(),
                                ),
                              );
                            }),
                      ),
                      // Container(
                      //   padding:
                      //   EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      //   decoration: ShapeDecoration(
                      //     color: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(0)),
                      //       side: BorderSide(color: Colors.black),
                      //     ),
                      //     shadows: [
                      //       const BoxShadow(
                      //         color: Colors.grey,
                      //         blurRadius: 0.2,
                      //         offset: Offset(5, 5),
                      //       )
                      //     ],
                      //   ),
                      //   child:IconButton(
                      //     color: Colors.grey,
                      //     iconSize: 30,
                      //     icon: const Icon(Icons.shopping_cart),
                      //     tooltip: 'cart',
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => cart_screen(),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   "Our Recommendation for You",
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(height: 2),
                // Text(
                //   "Based on your orders history",
                //   style: TextStyle(fontSize: 12),
                // ),
                SizedBox(
                  height: 5,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("Snapshot has data");
                          Personalcart model = snapshot.data;
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: model.data.length,
                              itemBuilder: (ctx, index) {
                                final item = model.data[index];
                                print(item.productId);
                                print(item.image);

                                return Dismissible(
                                  key: Key(item.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  // confirmDismiss: (direction){
                                  //
                                  // },

                                  onDismissed: (direction) {
                                    setState(() {
                                      id = model.data[index].id;
                                      ApiCall.personal_wishlist_remove(id);
                                      model.data.removeAt(index);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'item remove sucessfully')));
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (contx) =>
                                                  WishlistDetailScreen(
                                                    address: '',
                                                    price:
                                                        item.price.toString(),
                                                    name: '',
                                                    image:
                                                        item.image.toString(),
                                                    orderId: '',
                                                    quantity: item.quantity
                                                        .toString(),
                                                  )));
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                            Text(model
                                                                .data[index]
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
                //             Text('Rs. 1898'),
                //             Text('Saved Rs.324'),
                //           ],
                //         ),
                //       ),
                //       ButtonTheme(
                //         minWidth: 200,
                //         height: 35,
                //         buttonColor: Colors.red,
                //         child: RaisedButton(
                //           onPressed: () {
                //             openCheckout(total, email ,mobile);
                //           },
                //
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(3)),
                //           child: Padding(
                //             padding: const EdgeInsets.all(12.0),
                //             child: Text(
                //               'Cheakout',
                //               style: TextStyle(color: Colors.white, fontSize: 18),
                //             ),
                //           ),
                //         ),
                //       )
                //
                //
                //
                //
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }

//   onDismissed(id) {
//     setState(() {
//       ApiCall.personal_wishlist_remove(id);
//     });
//
//   }
// }

// Slidable(
// actionPane: SlidableDrawerActionPane(),
// actionExtentRatio: 0.2,
// // actions: <Widget>[
// //   IconSlideAction(
// //     caption: 'Archive',
// //     color: Colors.blue,
// //     icon: Icons.archive,
// //     onTap: () => {('Archive')},
// //   ),
// // ],
// secondaryActions: <Widget>[
//
// Container(
// height:110,
// child: IconSlideAction(
// caption: 'Delete',
// color: Colors.red,
// icon: Icons.delete,
// onTap: () =>onDismissed(item.id),
// ),
// ),
// ],
//
//
//
//
//
// child: Card(
// elevation: 5,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// // color: Colors.red,
// height: 100,
// child: Column(
// children: [
// Row(
// children: [
// // SizedBox(
// //   width: 10,
// //   height: 70,
// //
// // ),
// Image.network(
// item.image,
// height: 70,
// width: 90,
// fit: BoxFit.fill,
// ),
// SizedBox(
// width: 5,
// ),
// Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Row(
// children: [
// Text("Id : "),
// Text(
// item.id
//     .toString(),
// style: TextStyle(
// fontWeight:
// FontWeight.w600),
// ),
// ],
// ),
// SizedBox(
// height: 5,
// ),
// SizedBox(
// width: 60,
// child: Row(
// children: [
// Text("Qty : "),
// Text(
// item.quantity
//     .toString()),
// ],
// ),
// ),
// SizedBox(
// height: 5,
// ),
// SizedBox(
// // width: 60,
// child: Row(
// children: [
// Text(
// 'Rs .',
// style: TextStyle(
// fontWeight:
// FontWeight
//     .w900),
// ),
// Text(
// item.price
//     .toString(),
// style: TextStyle(
// fontWeight:
// FontWeight
//     .w900),
// ),
// ],
// ),
// ),
// ],
// ),
// // Padding(
// //   padding:
// //   const EdgeInsets.fromLTRB(
// //       40, 20, 10, 0),
// //   child: Container(
// //     width: 100,
// //     child: ElevatedButton(
// //       onPressed: () async {
// //         CartResponse cartResponse =
// //         await ApiCall.addTocart(
// //           user_id: user_id,
// //           product_id: model
// //               .product[index]
// //               .productId,
// //           price: model
// //               .product[index].price,
// //           quantity: "1",
// //         );
// //         Scaffold.of(context)
// //             .showSnackBar(SnackBar(
// //           duration:
// //           Duration(seconds: 8),
// //           content: Text(
// //               "item Added to cart"),
// //         ));
// //       },
// //       child: const Text(
// //         'Add',
// //       ),
// //       style: ButtonStyle(
// //           foregroundColor:
// //           MaterialStateProperty.all<Color>(
// //               Colors.white),
// //           backgroundColor:
// //           MaterialStateProperty
// //               .all<Color>(
// //               Colors.red),
// //           shape: MaterialStateProperty.all<
// //               RoundedRectangleBorder>(
// //               RoundedRectangleBorder(
// //                   borderRadius:
// //                   BorderRadius.zero,
// //                   side: BorderSide(color: Colors.red)))),
// //     ),
// //   ),
// // )
// ],
// ),
// ],
// ),
// ),
// ),
// ),
// );
}
