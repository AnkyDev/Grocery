import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/model/loginResponse.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/otp.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final _form = GlobalKey<FormState>();
  String response, otpData;
  bool isLoading;
  String phone;
  String mobile;
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    } else {
      phone = phoneNumberController.text..toString();
      LoginResponse loginResponse = await ApiCall.postlogin(
        mobile: phoneNumberController.text.toString(),
      );
      if (loginResponse == null) {
        print('data not  save or error');
      } else {
        if (loginResponse.success) {
          // print('Welcome ravan dtaat has been save in the data base');

          print(loginResponse.message);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OTPScreen(otpData, phone)),
          );

          setState(() {
            isLoading = false;
            otpData = loginResponse.otp.toString();
            print(otpData);
            response = loginResponse.message;

            Fluttertoast.showToast(
                msg: otpData,
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
    return Scaffold(
      body: Center(
        child: Container(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    autocorrect: true,
                    controller: phoneNumberController,
                    validator: (text) {
                      if (!(text.length == 10) && text.isNotEmpty) {
                        return "Enter valid 10 digit mobile number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      prefixIcon: Icon(Icons.call),
                      prefixText: "+91 ",
                      labelText: "Mobile No.",
                      counterText: "",
                      labelStyle: TextStyle(fontSize: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ButtonTheme(
                  minWidth: 300,
                  height: 35,
                  buttonColor: Colors.deepOrangeAccent,
                  child: RaisedButton(
                    onPressed: () {
                      _saveForm();
                      //GOTO otp screen
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OTPScreen(mobile)));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Send OTP',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
