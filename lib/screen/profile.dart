import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:grocery/model/add_address.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/address.dart';
import 'package:grocery/screen/custom_dialogue.dart';
import 'package:grocery/screen/order.dart';
import 'package:grocery/screen/profile_addres.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  Future<AddAddress> _future;
  String user_id;
  String Id;
  String User_name;
  String user_mobile;
  String user_image;

  Future getProfiledata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('user_id');
    var name = sharedPreferences.getString('fullName');
    var mobile = sharedPreferences.getString('mobile');
    var image = sharedPreferences.getString('profileImage');
    setState(() {
      user_id = id;
      _future = ApiCall.personal_address(user_id);

      Id = id;
      User_name = name;
      user_mobile = mobile;
      user_image = image;
    });
  }

  @override
  void initState() {
    getProfiledata();

    super.initState();
  }

  circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  XFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              painter: HeaderCurvedContainer(),
            ),
            // Positioned(
            //   top: 0.0,
            //   right: 0.0,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: new IconButton(
            //         icon: Icon(
            //           Icons.share,
            //           color: Colors.white,
            //         ),
            //         onPressed: () {}),
            //   ),
            // ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      user_mobile.toString(),
                      style: TextStyle(
                        fontSize: 25.0,
                        //letterSpacing: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: _imageFile == null
                            ? AssetImage('assets/img.png')
                            : FileImage(File(_imageFile.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: BottomSheetShape(),
                            backgroundColor: Colors.black,
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                //shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 10, color: Colors.black),
                                color: Colors.black),
                            child: Icon(
                              Icons.photo_camera_rounded,
                              color: Colors.white,
                            ))),
                    alignment: Alignment.bottomRight,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Text(User_name),
                  Card(
                    color: Colors.white,
                    elevation: 6.0,
                    margin: EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => order(),
                              ),
                            );
                          },
                          child: const ListTile(
                            leading: Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.black,
                            ),
                            title: Text(
                              'My Orders',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 6.0,
                    margin: EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // const ListTile(
                        //   leading: Icon(
                        //     Icons.home_rounded,
                        //     color: Colors.black,
                        //   ),
                        //   title: Text(
                        //     'Address',
                        //     style: TextStyle(color: Colors.black, fontSize: 20),
                        //   ),
                        //   subtitle: Text('131 Street Road, Boston, NewYork'),
                        // ),
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
                                  else
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
                                                //height: 150,
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
                                                              'Name: ${model.data.last.name}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 50,
                                                          ),
                                                          Align(
                                                              alignment:
                                                                  Alignment
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
                                                                // decoration: BoxDecoration(
                                                                //    // border: Border.all(color: Colors.green)
                                                                // ),
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
                                                            model.data.last
                                                                .roadNo,
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
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                model.data.last
                                                                    .pinCode,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
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
                                                            model.data.last
                                                                .state,
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
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: TextButton.icon(
                              icon: Icon(Icons.add),
                              label: Text(
                                'Add Address',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            AddAccountAddress()));
                              },
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFFF48221)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: BorderSide(
                                              color: Colors.black)))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 95,
                  ),
                  new Container(
                    height: 50,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new TextButton.icon(
                          icon: Icon(Icons.delete_rounded),
                          label: new Text("Delete Account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          //color:  Colors.blueAccent[600],
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFF48221)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black)))),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: "Delete Account",
                                    descriptions:
                                        "Are you sure you want to delete your account?",
                                    text: "Yes",
                                  );
                                });
                          },
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        new TextButton.icon(
                          icon: Icon(Icons.logout),
                          label: new Text(
                            "Sign Out",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          //color:  Colors.blueAccent[600],
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFF48221)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.black)))),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      padding: EdgeInsets.only(top: 34, bottom: 16, left: 48, right: 48),
      height: 180,
      width: 200,
      //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Choose your profile photo',
            style: TextStyle(fontSize: 23, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text(
                  'Camera',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    XFile pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFFF48221);
    Path path = Path()
      ..relativeLineTo(0, 340)
      ..quadraticBezierTo(size.width / 2, 100.0, size.width, 340)
      ..relativeLineTo(0, -400)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BottomSheetShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 60);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
