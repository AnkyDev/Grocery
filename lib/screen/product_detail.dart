//import 'dart:async';
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grocery/model/productResponse.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class product_detail extends StatefulWidget {
  final String id;
  final String pid;
  final String name;
  final String price;
  final String category;
  final String image;
  product_detail(
      this.id, this.pid, this.category, this.price, this.name, this.image,
      {Key key})
      : super(key: key);

  @override
  _product_detailState createState() => _product_detailState();
}

class _product_detailState extends State<product_detail> {
  String rid;
  String rpid;
  String rimage;
  String rname;
  String rprice;
  String rcategory;
  String user_id;

  @override
  void initState() {
    rid = widget.id;
    rpid = widget.pid;
    rname = widget.name;
    rprice = widget.price;
    rcategory = widget.category;
    rimage = widget.image;

    // print("Hello ravan your id ${user_id} welcome to this world");

    super.initState();
  }

  // late Timer _timer;
  // int seconds = 0;
  // int minutes = 0;
  // int hours = 0;
  var rating = 3.0;
  @override
  Widget build(BuildContext context) {
    // var note;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // title: Text("Mirraw",
          //   style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold
          //   ),),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.search),
          //   ),
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.shopping_cart_rounded),
          //   ),
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.share),
          //   ),
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.menu),
          //   ),
          // ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      child: Image.network(
                        // model.product[index].image,
                        rimage,

                        fit: BoxFit.fill,
                        // height: 70,
                        // width: 90,
                      ),
                      margin: EdgeInsets.all(6.0),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(8.0),
                      //   // image: DecorationImage(
                      //   //   image: AssetImage("asset/pendets.jpg"),
                      //   // ),
                      // ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      child: Image.network(
                        // model.product[index].image,
                        rimage,

                        fit: BoxFit.fill,
                        // height: 70,
                        // width: 90,
                      ),
                      margin: EdgeInsets.all(3.0),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(8.0),
                      //   // image: DecorationImage(
                      //   //   image: Image.network(src),
                      //   // ),
                      // ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 350.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 4000),
                  viewportFraction: 0.7,
                ),
              ),
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              rname,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child:  IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(Icons.favorite_border),
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                          ),
                          Text(
                            "Price :  Rs  ${rprice}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Colors.red),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          // Text(
                          //   "7999",
                          //   style: TextStyle(
                          //       decoration: TextDecoration.lineThrough),
                          // ),
                          SizedBox(
                            width: 8,
                          ),
                          // Text(
                          //   "65% Off",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.normal,
                          //       fontSize: 19,
                          //       color: Colors.red),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child:Column(
                    //     children: [
                    //       Text("  Deal End In ",
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.normal,
                    //           fontSize: 15,
                    //         ),),
                    //     ],
                    //   ),
                    // ),
                    // SmoothStarRating(
                    //   rating: rating,
                    //   isReadOnly: false,
                    //   size: 30,
                    //   filledIconData: Icons.star,
                    //   halfFilledIconData: Icons.star_half,
                    //   defaultIconData: Icons.star_border,
                    //   starCount: 5,
                    //   allowHalfRating: true,
                    //   spacing: 2.0,
                    //   onRated: (value) {
                    //     print("rating value -> $value");
                    //     // print("rating value dd -> ${value.truncate()}");
                    //   },
                    // ),
                    // SizedBox(height: 50,),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child:Column(
                    //     children: [
                    //       SizedBox(width: 400,),
                    //       Text("  Cash On Delivery Avaliability",
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.normal,
                    //           fontSize: 15,
                    //         ),),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children:<Widget> [
              //       SizedBox(width: 50,),
              //       Expanded(
              //         child:TextField(
              //           decoration: InputDecoration(
              //             hintText: "Enter Pin",
              //           ),
              //         ),
              //       ),
              //       FlatButton(onPressed: (){}, child: Text("Check",),color: Colors.red,),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 17,
              ),
              Container(
                // color: Colors.yellow,
                width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(width: 50,),
                    Card(
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Add to Cart",
                        ),
                        color: Colors.white,
                        minWidth: 170,
                      ),
                    ),
                    // SizedBox(width: 100,),
                    Card(
                      color: Colors.red,
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Buy Now",
                        ),
                        color: Colors.red,
                        minWidth: 170,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "About The Product",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ExpansionTile(
                      title: Text(
                        "SPECIFICATION",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              // SizedBox(width: 120,),
                              Text(
                                "     Product Id                     :    6765676",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),

                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Shipping                       :    abcd",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),

                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Work                            :    jhkf",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "     Color                           :    yellow",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "    Plating                        :    abcd",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "  Base Material              :    abcd",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Earing Height             :      19",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Earing Width              :      19",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ExpansionTile(
                        title: Text(
                          "SHIPPING",
                          style: TextStyle(color: Colors.red),
                        ),
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            child: Column(children: [
                              Text(
                                "           Once your order is packed and shipped , You will get Notification with your tracking information",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Text(
                                "          Order takes anywhere from 3 to 15 day to arrive depending on your local postal Service ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                            ]),
                          ),
                        ])
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ExpansionTile(
                        title: Text(
                          "PAYMENT",
                          style: TextStyle(color: Colors.red),
                        ),
                        children: [
                          Text(
                            "Cash on delivery is avaliable",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Net Banking and Card Payment is avaliable",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                        ]),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ExpansionTile(
                        title: Text(
                          "RETURNS",
                          style: TextStyle(color: Colors.red),
                        ),
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "7 days Return Policy",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ]),
                  ],
                ),
              ),

              SizedBox(
                height: 35,
              ),

              // Container(
              //   //height: 80,
              //   width: MediaQuery.of(context).size.width - 10,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //     color: Colors.white,
              //     // boxShadow: [
              //     //   BoxShadow(
              //     //       color: Theme.of(context).hintColor.withOpacity(0.2),
              //     //       spreadRadius: 2,
              //     //       blurRadius: 5)
              //     // ],
              //   ),
              //   child: Column(
              //     children: [
              //
              //       ExpansionTile(
              //
              //           title: Text("View More Necklace Set",
              //             style: TextStyle(
              //                 color:Colors.black,
              //                 fontWeight: FontWeight.bold
              //             ),),
              //           children:[
              //             Card(
              //               child: Row(
              //                 children: [
              //                   Container(
              //
              //                     height: 242,
              //                     width: 160,
              //                     color:Colors.white,
              //                     child: Column(
              //                       children: [
              //                         Card(
              //                           child: Image.asset(
              //                             'asset/necklace1.jpg',
              //                             fit: BoxFit.cover,
              //                           ),
              //                         ),
              //
              //                         Text("Golden Necklace",
              //                           style: TextStyle(
              //                               fontSize: 15,
              //                               fontWeight: FontWeight.normal,
              //                               color: Colors.black
              //                           ),),
              //
              //
              //                         Text("Rs. 629",
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold
              //                           ),),
              //
              //
              //
              //                       ],
              //                     ),
              //
              //                   ),
              //                   SizedBox(width: 20,),
              //                   Container(
              //
              //                     height: 242,
              //                     width: 160,
              //                     color:Colors.white,
              //                     child: Column(
              //                       children: [
              //                         Card(
              //                           child: Image.asset(
              //                             'asset/necklace2.jpg',
              //                             fit: BoxFit.cover,
              //                           ),
              //                         ),
              //                         Text("Golden Necklace",
              //                           style: TextStyle(
              //                               fontSize: 15,
              //                               fontWeight: FontWeight.normal,
              //                               color: Colors.black
              //                           ),),
              //                         Text("Rs. 1629",
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold
              //                           ),),
              //
              //
              //                       ],
              //                     ),
              //
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Card(
              //               child: Row(
              //                 children: [
              //                   Container(
              //
              //                     height: 242,
              //                     width: 160,
              //                     color:Colors.white,
              //                     child: Column(
              //                       children: [
              //                         Card(
              //                           child: Image.asset(
              //                             'asset/necklace3.jpg',
              //                             fit: BoxFit.cover,
              //                           ),
              //                         ),
              //
              //                         Text("Golden Necklace",
              //                           style: TextStyle(
              //                               fontSize: 15,
              //                               fontWeight: FontWeight.normal,
              //                               color: Colors.black
              //                           ),),
              //
              //
              //                         Text("Rs. 9999",
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold
              //                           ),),
              //
              //
              //
              //                       ],
              //                     ),
              //
              //                   ),
              //                   SizedBox(width: 20,),
              //                   Container(
              //
              //                     height: 242,
              //                     width: 160,
              //                     color:Colors.white,
              //                     child: Column(
              //                       children: [
              //                         Card(
              //                           child: Image.asset(
              //                             'asset/necklace4.jpg',
              //                             fit: BoxFit.cover,
              //                           ),
              //                         ),
              //                         Text("Golden Necklace",
              //                           style: TextStyle(
              //                               fontSize: 15,
              //                               fontWeight: FontWeight.normal,
              //                               color: Colors.black
              //                           ),),
              //                         Text("Rs. 8629",
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold
              //                           ),),
              //
              //
              //                       ],
              //                     ),
              //
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ]
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   // height: 80,
              //   width: MediaQuery.of(context).size.width - 10,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //     color: Colors.white,
              //     // boxShadow: [
              //     //   BoxShadow(
              //     //       color: Theme.of(context).hintColor.withOpacity(0.2),
              //     //       spreadRadius: 2,
              //     //       blurRadius: 5)
              //     // ],
              //   ),
              //   child: Column(
              //     children: [
              //
              //       ExpansionTile(
              //
              //         title: Text("View More Product BY Classiques",
              //           style: TextStyle(
              //               color:Colors.black,
              //               fontWeight: FontWeight.bold
              //           ),),
              //         children: [
              //
              //           Card(
              //             child: Row(
              //               children: [
              //                 Container(
              //
              //                   height: 242,
              //                   width: 160,
              //                   color:Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Card(
              //                         child: Image.asset(
              //                           'asset/necklace5.jpg',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //
              //                       Text("Golden Necklace",
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.normal,
              //                             color: Colors.black
              //                         ),),
              //
              //
              //                       Text("Rs. 6788",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold
              //                         ),),
              //
              //
              //
              //                     ],
              //                   ),
              //
              //                 ),
              //                 SizedBox(width: 20,),
              //                 Container(
              //
              //                   height: 242,
              //                   width: 160,
              //                   color:Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Card(
              //                         child: Image.asset(
              //                           'asset/necklace6.jpg',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                       Text("Golden Necklace",
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.normal,
              //                             color: Colors.black
              //                         ),),
              //                       Text("Rs. 7659",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold
              //                         ),),
              //
              //
              //                     ],
              //                   ),
              //
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Card(
              //             child: Row(
              //               children: [
              //                 Container(
              //
              //                   height: 242,
              //                   width: 160,
              //                   color:Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Card(
              //                         child: Image.asset(
              //                           'asset/necklace7.jpg',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //
              //                       Text("Golden Necklace",
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.normal,
              //                             color: Colors.black
              //                         ),),
              //
              //
              //                       Text("Rs. 8768",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold
              //                         ),),
              //
              //
              //
              //                     ],
              //                   ),
              //
              //                 ),
              //                 SizedBox(width: 20,),
              //                 Container(
              //
              //                   height: 242,
              //                   width: 160,
              //                   color:Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Card(
              //                         child: Image.asset(
              //                           'asset/necklace8.jpg',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                       Text("Golden Necklace",
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.normal,
              //                             color: Colors.black
              //                         ),),
              //                       Text("Rs. 5489",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold
              //                         ),),
              //
              //
              //                     ],
              //                   ),
              //
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              // Container(
              //   // height: 480,
              //   width: MediaQuery.of(context).size.width - 10,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //     color: Colors.white,
              //     // boxShadow: [
              //     //   BoxShadow(
              //     //       color: Theme.of(context).hintColor.withOpacity(0.2),
              //     //       spreadRadius: 2,
              //     //       blurRadius: 5)
              //     // ],
              //   ),
              //   child: Column(
              //     children: [
              //
              //       ExpansionTile(
              //
              //         title: Text("You May Also Like",
              //           style: TextStyle(
              //               color:Colors.black,
              //               fontWeight: FontWeight.bold
              //           ),),
              //         children: [
              //           Card(
              //             child: Row(
              //               children: [
              //                 Container(
              //
              //                   height: 242,
              //                   width: 160,
              //                   color:Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Card(
              //                         child: Image.asset(
              //                           'asset/danglers.jpg',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //
              //                       Text("Golden Necklace",
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.normal,
              //                             color: Colors.black
              //                         ),),
              //
              //
              //                       Text("Rs. 629",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold
              //                         ),),
              //
              //
              //
              //                     ],
              //                   ),
              //
              //                 ),
              //                 SizedBox(width: 20,),
              //                 Container(
              //
              //                   height: 242,
              //                   width: 160,
              //                   color:Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Card(
              //                         child: Image.asset(
              //                           'asset/unnamed.jpg',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                       Text("Golden Necklace",
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.normal,
              //                             color: Colors.black
              //                         ),),
              //                       Text("Rs. 1629",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold
              //                         ),),
              //
              //
              //                     ],
              //                   ),
              //
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Card(
              //             child: Row(
              //               children: [
              //                 Container(
              //
              //                   height: 242,
              //                   width: 160,
              //                   color:Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Card(
              //                         child: Image.asset(
              //                           'asset/new.jpg',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //
              //                       Text("Golden Necklace",
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.normal,
              //                             color: Colors.black
              //                         ),),
              //
              //
              //                       Text("Rs. 629",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold
              //                         ),),
              //
              //
              //
              //                     ],
              //                   ),
              //
              //                 ),
              //                 SizedBox(width: 20,),
              //                 Container(
              //
              //                   height: 242,
              //                   width: 160,
              //                   color:Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Card(
              //                         child: Image.asset(
              //                           'asset/new.jpg',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                       Text("Golden Necklace",
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.normal,
              //                             color: Colors.black
              //                         ),),
              //                       Text("Rs. 1629",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold
              //                         ),),
              //
              //
              //                     ],
              //                   ),
              //
              //                 ),
              //               ],
              //             ),
              //           ),
              //
              //         ],
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
//  startTimer() {
//   const oneSec = const Duration(seconds: 1);
//   _timer = new Timer.periodic(
//     oneSec,
//         (Timer timer) => setState(
//           () {
//         if (seconds < 0) {
//           timer.cancel();
//         } else {
//           seconds = seconds + 1;
//           if (seconds > 59) {
//             minutes += 1;
//             seconds = 0;
//             if (minutes > 59) {
//               hours += 1;
//               minutes = 0;
//             }
//           }
//         }
//       },
//     ),
//   );
// }
}
