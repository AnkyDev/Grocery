import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/model/add_address.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/delivery.dart';
import 'package:grocery/screen/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddAccountAddress extends StatefulWidget {
  @override
  _AddAccountAddressState createState() => _AddAccountAddressState();
}

class _AddAccountAddressState extends State<AddAccountAddress> {
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController pin = new TextEditingController();
  TextEditingController state = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController house = new TextEditingController();
  TextEditingController road = new TextEditingController();
  final _form = GlobalKey<FormState>();
  String user_id;
  String result;
  String Name;
  String Phone;
  String Pin;
  String State;
  String City;
  String House;
  String Road;
  bool isLoading;

  @override
  void initState() {

    getvalidationData();
    print("Hello ravan your id ${user_id} welcome to this world");
    // _future = ApiCall.fetchProductResponse();
    super.initState();
  }
  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('user_id');
    setState(() {
      user_id = userid;
    });
    print(user_id);
  }
  Future<void> _saveaddress() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    } else {
      // Name=name.text.toString();
      // Phone=phone.text.toString();
      // Pin=pin.text.toString();
      // State=state.text.toString();
      // City=city.text.toString();
      // House=house.text.toString();
      // Road=road.text.toString();
      AddAddress addAddress = await ApiCall.addAddress(
        user_id: user_id,
        name:name.text.toString(),
        phone: phone.text.toString(),
        pin_code: pin.text.toString(),
        state:state.text.toString(),
        city: city.text.toString(),
        house_no:road.text.toString(),
        road_no: road.text.toString(),
      );
      if (addAddress == null) {
        print('data not  save or error');
      } else {
        if (addAddress.responce == true) {
          // print('Welcome ravan dtaat has been save in the data base');

          print(addAddress.data);


          setState(() {

            isLoading = false;
            result = addAddress.responce.toString();
            print(result);
            //  response = loginResponse.message;

            Fluttertoast.showToast(
                msg: result,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 200,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
            // print("signupResponse of it is:"+ signUpResponse)
          });
        }
      }
      // print(emailController.text);
      // print( phoneNumberController.text);
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Add your Address'),
        ),
        body: Stack(
          children: [

            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    nameTextField(),
                    SizedBox(height: 20,),
                    phoneNumberField(),
                    SizedBox(height: 20,),
                    pinCodeField(),
                    SizedBox(height: 20,),
                    stateField(),
                    SizedBox(height: 20,),
                    cityField(),
                    SizedBox(height: 20,),
                    houseField(),
                    SizedBox(height: 20,),
                    roadField(),
                    saveAddressButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget nameTextField(){
    return TextFormField(
      controller: name,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.teal
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "Name",
        hintText: "Name (Required*)",
      ),
    );
  }
  Widget phoneNumberField(){
    return TextFormField(
      controller: phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.teal
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "Phone Number",
        hintText: "Phone Number (Required*)",
      ),
    );
  }
  Widget pinCodeField(){
    return TextFormField(
      controller: pin,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.teal
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "Pin Code",
        hintText: "Pin Code (Required*)",
      ),
    );
  }
  Widget stateField(){
    return TextFormField(
      controller: state,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.teal
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "State",
        hintText: "State (Required*)",
      ),
    );
  }
  Widget cityField(){
    return TextFormField(
      controller: city,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.teal
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "City",
        hintText: "City (Required*)",
      ),
    );
  }
  Widget houseField(){
    return TextFormField(
      controller: house,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.teal
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "House No.",
        hintText: "House No., Building Name (Required*)",
      ),
    );
  }
  Widget roadField(){
    return TextFormField(
      controller: road,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.teal
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        labelText: "Road Name",
        hintText: "Road Name, Area, Colony (Required*)",
      ),
    );
  }
  Widget saveAddressButton(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              _saveaddress();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profile()),
              );
              // var route = new MaterialPageRoute(
              //   builder: (BuildContext context) => new Save(value: name.text, val2: phone.text, val3: pin.text, val4: state.text, val5: city.text, val6: house.text, val1: road.text,),
              // );
              // Navigator.of(context).push(route);
            },
            child: Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text("Save Address", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
            ),
          ),
        ],
      ),
    );
  }
}
