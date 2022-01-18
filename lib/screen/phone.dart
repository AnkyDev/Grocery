import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'otp.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); },
        ),
        elevation: 0.0,
      ),
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 90,),
              Container(
                width: 100,
                height: 100,
                child: Image.asset('assets/images/shop.png', fit: BoxFit.cover,),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold, color: Colors.red),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text('You will receive an OTP after entering your mobile number', style: TextStyle(fontSize: 18, color: Colors.pinkAccent),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              SizedBox(height: 50.0,),
              InkWell(
                onTap: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => OTP()));
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 16),)),
                ),
              ),
              SizedBox(height:40.0),
              GestureDetector(
                onTap: (){

                },
                child: Text.rich(
                  TextSpan(
                      text: 'Don\'t have an account',
                      children: [
                        TextSpan(
                          text: 'Signup',
                          style: TextStyle(
                              color: Color(0xffEE7B23)
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
