import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery/model/cartResponse.dart';
import 'package:grocery/model/categoryResponse.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/address.dart';
import 'package:grocery/screen/cart.dart';
import 'package:grocery/screen/product_screen.dart';
import 'package:grocery/screen/profile.dart';
import 'package:grocery/screen/wishlist.dart';
import 'package:grocery/screen/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'wallet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<CategoryResponse> _future;
  String id;
  Future<Personalcart> _future2;
  String user_id;
  @override
  void initState() {
    _future = ApiCall.fetchCategoryResponse();
    // _future2 = ApiCall.personal_cart(user_id);
    callmeplz();
    super.initState();
  }

  circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  final textController = TextEditingController();
  // final databaseRef = FirebaseDatabase.instance.reference();
  // final Future<FirebaseApp> _future = Firebase.initializeApp();
  int _currentIndex = 0;

  // void readData() {
  //   databaseRef.once().then((DataSnapshot snapshot) {
  //     print('Data : ${snapshot.value}');
  //   });
  // }

  final List<String> imgList = [
    'assets/slide1.jpg'
        'assets/slide2.jpg'
        'assets/slide3.jpg'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future callmeplz() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('user_id');

    setState(() {
      user_id = userid;
      _future2 = ApiCall.personal_cart(user_id);
      print(_future2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.fromLTRB(8, 15, 8, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
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
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
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
                    width: 7,
                  ),
                  Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
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
                    child: Stack(
                      children: [
                        IconButton(
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
                        Positioned(
                          right: 8,
                          left: 18,
                          child: new Container(
                              padding: EdgeInsets.all(2),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: FutureBuilder(
                                  future: _future2,
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
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            SizedBox(
              height: 30,
            ),
            CarouselSlider(
              items: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Image(
                    image: AssetImage(
                      "assets/dassets/slide1.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Image(
                    image: AssetImage(
                      "assets/dassets/slide2.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Image(
                    image: AssetImage(
                      "assets/dassets/slide3.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                )
              ],
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 400),
                viewportFraction: 0.8,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
                child: Text(
              "Featured Categories",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                  letterSpacing: 1.5),
            )),

            Container(
              //color: Colors.red,
              height: 500,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      child: FutureBuilder(
                          future: _future,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print("Snapshot has data");
                              CategoryResponse model = snapshot.data;

                              return Center(
                                child: Container(
                                  child: GridView.builder(
                                    itemCount: model.category.length,
                                    // physics: NeverScrollableScrollPhysics(),
                                    physics: ScrollPhysics(),
                                    // scrollDirection: Axis.vertical,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 6),

                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 3 / 3,
                                            crossAxisSpacing: 4,
                                            mainAxisSpacing: 5),
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      product_screen(id = model
                                                          .category[index].id
                                                        ),
                                                ));
                                          },
                                          child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Ink.image(
                                                    image: NetworkImage(
                                                        "http://daytoday.krashitservices.com/day_to_day/uploads/category/${model.category[index].image}" ==
                                                                null
                                                            ? 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'
                                                            : "http://daytoday.krashitservices.com/day_to_day/uploads/category/${model.category[index].image}"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7),
                                                    height: 120,
                                                    color: Colors.black38,
                                                    child: Text(
                                                      model.category[index].name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else {
                              // print(snapshot.error.toString());
                              return circularProgress();
                            }
                          }))
                ],
              ),
            ),
          ]),
        )),
      ),
      drawer: _categoriesDrawer(context),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _onItemTapped,
      //   currentIndex: _currentIndex,
      //   fixedColor: Colors.grey.shade700,
      //   backgroundColor: Colors.grey.shade300,
      //   type: BottomNavigationBarType.fixed,
      //   // new
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //         color: Colors.grey.shade700,
      //       ),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: InkWell(
      //         onTap: () {
      //
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //     builder: (context) => CategoriesScreen(),
      //           //   ),
      //           // );
      //         },
      //         child: Icon(
      //           Icons.menu,
      //           color: Colors.grey.shade700,
      //         ),
      //       ),
      //       label: 'Category',
      //     ),
      //     BottomNavigationBarItem(
      //         icon: InkWell(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => wallet(),
      //               ),
      //             );
      //           },
      //           child: Icon(
      //             Icons.account_balance_wallet,
      //             color: Colors.grey.shade800,
      //           ),
      //         ),
      //         label: 'Wallet'),
      //
      //
      //     BottomNavigationBarItem(
      //         icon: InkWell(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => profile(),
      //               ),
      //             );
      //           },
      //           child: Icon(
      //             Icons.person,
      //             color: Colors.grey.shade800,
      //           ),
      //         ),
      //         label: 'Profile')
      //   ],
      // ),
    );
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(StringProperty('name', name));
  // }
}

Widget _categoryCard(BuildContext context, String title) {
  return Card(
    elevation: 5,
    child: Container(
        padding: EdgeInsets.all(15),
        child: Column(children: [
          // Image.asset(
          //   "image_location",
          //   fit: BoxFit.contain,
          // ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 15),
          )
        ])),
  );
}

Widget _categoriesDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        Container(
          child: DrawerHeader(
              child: Text(
            "Categories",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
          )),
        ),
        ListTile(
          title: Text(
            "Fruits and Vegitables",
            style: TextStyle(fontSize: 18),
          ),
          trailing: Icon(Icons.arrow_downward_sharp),
        ),
        Divider(),
        ListTile(
          title: Text(
            "Foodgrains, Oil & Masala",
            style: TextStyle(fontSize: 18),
          ),
          trailing: Icon(Icons.arrow_downward_sharp),
        ),
        Divider(),
        ListTile(
          title: Text(
            "Bakery, Cakes and Dairy",
            style: TextStyle(fontSize: 18),
          ),
          trailing: Icon(Icons.arrow_downward_sharp),
        ),
        Divider(),
        ListTile(
          title: Text(
            "Beverages",
            style: TextStyle(fontSize: 18),
          ),
          trailing: Icon(Icons.arrow_downward_sharp),
        ),
      ],
    ),
  );
}
