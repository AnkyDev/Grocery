import 'package:flutter/material.dart';
import 'package:grocery/model/addToCartResponse.dart';
import 'package:grocery/model/compair_fav_model.dart';
import 'package:grocery/model/productResponse.dart';
import 'package:grocery/model/wishlist_model.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/cart.dart';
import 'package:grocery/screen/product_detail.dart';
import 'package:grocery/screen/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:share/share.dart';

class product_screen extends StatefulWidget {
  final String id;
  product_screen(this.id, {Key key}) : super(key: key);

  @override
  _product_screenState createState() => _product_screenState();
}

class _product_screenState extends State<product_screen> {
  Future<ProductResponse> _future;
  Future<CompairFav> _future2;
  String id;
  String image;
  String name;
  String price;
  String category;
  String user_id;
  String pid;
  String _dropDownValue;
  String shareId;
  String shareName;
  String sharePrice;

  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('user_id');
    setState(() {
      user_id = userid;
    });
    print(user_id);
  }

  Future<CompairFav> getFuture(String userIDs, String proIDs) =>
      Future.delayed(Duration(seconds: 0), () {
        return ApiCall.CompareFavProduct(user_id: userIDs, pro_id: proIDs);
      });

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
    // linkUrl: 'https://flutter.dev/',
    // chooserTitle: 'Example Chooser Title'
  }

  @override
  void initState() {
    id = widget.id;
    print(id);
    getvalidationData();

    print("Hello ravan your id ${user_id} welcome to this world");
    _future = ApiCall.fetchProductResponse(widget.id);
    super.initState();
  }

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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
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
                            tooltip: 'wishlist',
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
                            hintText: 'Search',
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
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("Snapshot has data");
                          ProductResponse model = snapshot.data;
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: model.product.length,
                              itemBuilder: (ctx, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => product_detail(
                                              id = model.product[index].id
                                                  .toString(),
                                              pid = model
                                                  .product[index].productId
                                                  .toString(),
                                              category = model
                                                  .product[index].category
                                                  .toString(),
                                              price = model.product[index].price
                                                  .toString(),
                                              name = model.product[index].name
                                                  .toString(),
                                              image =
                                                  'http://daytoday.krashitservices.com/day_to_day/uploads/product/${model.product[index].image}'),
                                          //'https://images.unsplash.com/photo-1604503468506-a8da13d82791?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
                                        ));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        // color: Colors.red,
                                        height: 130,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                // SizedBox(
                                                //   width: 100,
                                                //   height: 70,
                                                // ),
                                                // Ink.image(
                                                //   image: NetworkImage(
                                                //       'https://images.unsplash.com/photo-1604503468506-a8da13d82791?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
                                                //   fit: BoxFit.cover,
                                                // ),
                                                Container(
                                                  // color:Colors.red,
                                                  child: Image.network(
                                                    // model.product[index].image,
                                                    "http://daytoday.krashitservices.com/day_to_day/uploads/product/${model.product[index].image}",
                                                    // 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
                                                    fit: BoxFit.fill,
                                                    height: 70,
                                                    width: 90,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      model.product[index].name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text("Qty : "),
                                                        // Container(
                                                        //   // padding: const EdgeInsets.only(bottom: 1),
                                                        //   color: Colors.white60,
                                                        //   width: 140,
                                                        //   child:
                                                        //       new DropdownButtonHideUnderline(
                                                        //     child:
                                                        //         DropdownButton(
                                                        //       hint:
                                                        //           _dropDownValue ==
                                                        //                   null
                                                        //               ? Text(
                                                        //                   "100g Bag ",
                                                        //                   style: TextStyle(
                                                        //                       color: Colors.black54,
                                                        //                       fontSize: 12),
                                                        //                 )
                                                        //               : Text(
                                                        //                   _dropDownValue,
                                                        //                   style: TextStyle(
                                                        //                       color: Colors.black54,
                                                        //                       fontSize: 12),
                                                        //                 ),
                                                        //       // isExpanded: true,
                                                        //       iconSize: 25.0,
                                                        //       style: TextStyle(
                                                        //           color: Colors
                                                        //               .black),

                                                        //       items: [
                                                        //         "100g Bag in Box",
                                                        //         "200g Bag in box",
                                                        //         "300g Bag in box",
                                                        //         "400g Bag in Box",
                                                        //         "500g Bag in Box",
                                                        //         "600g Bag in Box",
                                                        //         "700g bag in Box",
                                                        //         "800g bag in Box",
                                                        //         "900g bag in Box",
                                                        //         "1kg bag in Box",
                                                        //         "2kg bag in Box",
                                                        //         "3kg bag in Box",
                                                        //         "4kg bag in Box",
                                                        //         "5kg bag in Box",
                                                        //         "6kg bag in Box",
                                                        //         "7kg bag in Box",
                                                        //         "8kg bag in Box",
                                                        //         "9kg bag in Box",
                                                        //         "10kg bag in Box",
                                                        //       ].map(
                                                        //         (val) {
                                                        //           return DropdownMenuItem<
                                                        //               String>(
                                                        //             value: val,
                                                        //             child: Text(
                                                        //                 val),
                                                        //           );
                                                        //         },
                                                        //       ).toList(),
                                                        //       onChanged: (val) {
                                                        //         setState(
                                                        //           () {
                                                        //             _dropDownValue =
                                                        //                 val;
                                                        //           },
                                                        //         );
                                                        //       },
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      //  width: 60,
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
                                                            model.product[index]
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
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                    // child: IconButton(
                                                    //   icon: Icon(Icons.favorite),
                                                    //   onPressed: () async {
                                                    //     CompairFav compairFav =
                                                    //         await ApiCall
                                                    //             .CompareFavProduct(
                                                    //                 user_id:
                                                    //                     user_id,
                                                    //                 pro_id: model
                                                    //                     .product[
                                                    //                         index]
                                                    //                     .productId);
                                                    //   },
                                                    // ),
                                                    // color: Colors.redAccent,
                                                    // width: 100,
                                                    child: FutureBuilder(
                                                  future:
                                                      ApiCall.CompareFavProduct(
                                                          user_id: user_id,
                                                          pro_id: model
                                                              .product[index]
                                                              .productId),
                                                  builder:
                                                      (context2, snapshot2) {
                                                    if (snapshot2.hasData) {
                                                      CompairFav model2 =
                                                          snapshot2.data;
                                                      return FavoriteButton(
                                                        iconSize: 40,
                                                        isFavorite: //true,

                                                            model2.data == true
                                                                ? true
                                                                : false,
                                                        // iconDisabledColor: Colors.white,
                                                        valueChanged:
                                                            (_isFavorite) async {
                                                          print(
                                                              'Is Favorite : $_isFavorite');

                                                          WishlistResponse
                                                              wishlistResponse =
                                                              await ApiCall
                                                                  .addTowishlist(
                                                            user_id: user_id,
                                                            product_id: model
                                                                .product[index]
                                                                .productId,
                                                            price: model
                                                                .product[index]
                                                                .price,
                                                            quantity: "1",
                                                            image:
                                                                //'https://images.unsplash.com/photo-1604503468506-a8da13d82791?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
                                                                "http://daytoday.krashitservices.com/day_to_day/uploads/product/${model.product[index].image}",
                                                          );
                                                          Scaffold.of(context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            duration: Duration(
                                                                seconds: 2),
                                                            content: Text(
                                                                "item Added to wishlist"),
                                                          ));
                                                        },
                                                      );
                                                    } else
                                                      return circularProgress();
                                                  },
                                                )),

                                                // SizedBox(
                                                //   width: 10,
                                                // ),

                                                IconButton(
                                                  color: Colors.grey,
                                                  iconSize: 25,
                                                  icon: const Icon(Icons.share),
                                                  tooltip: 'share',
                                                  onPressed: share,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: 140,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      CartResponse
                                                          cartResponse =
                                                          await ApiCall
                                                              .addTocart(
                                                        user_id: user_id,
                                                        product_id: model
                                                            .product[index].id,
                                                        price: model
                                                            .product[index]
                                                            .price,
                                                        quantity: "1",
                                                        image:
                                                            "http://daytoday.krashitservices.com/day_to_day/uploads/product/${model.product[index].image}",
                                                        //'https://images.unsplash.com/photo-1604503468506-a8da13d82791?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
                                                        //  "http://daytoday.krashitservices.com/day_to_day/uploads/product/${model.product[index].image}",
                                                      );
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        duration: Duration(
                                                            seconds: 1),
                                                        content: Text(
                                                            "item Added to cart"),
                                                      ));
                                                    },
                                                    child: const Text(
                                                      'Add',
                                                    ),
                                                    style: ButtonStyle(
                                                        foregroundColor:
                                                            MaterialStateProperty.all<Color>(
                                                                Colors.white),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors.red),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.zero,
                                                                side: BorderSide(color: Colors.red)))),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          // print(snapshot.error.toString());
                          return circularProgress();
                          //Text(snapshot.error.toString());
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
