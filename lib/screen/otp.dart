import 'package:flutter/material.dart';
import 'package:grocery/model/verfityOtp.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/home.dart';
import 'package:grocery/screen/home_screen.dar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  final String otpData;
  final String phone;
  OTPScreen(this.otpData, this.phone, {Key key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpController = TextEditingController();

  final _form = GlobalKey<FormState>();

  String mobileNo, otp, response;
  String Mobile;
  String id;
  String data;

  bool isLoading;

  Future<void> _VerifyLoginOtp() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    } else {
      data = widget.otpData;

      mobileNo = widget.phone;
      otp = _otpController.text;
      VerfiyOtp verfiyOtp =
          await ApiCall.postverifyOtp(mobile: mobileNo, otp: otp);
      if (VerfiyOtp == null) {
        print('data not  sent or error');
      } else {
        if (verfiyOtp.response) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => home()),
          );

          print(verfiyOtp.status);
          print(verfiyOtp.response);

          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("user_id", verfiyOtp.data.id.toString());
          sharedPreferences.setString(
              "user_otp", verfiyOtp.data.otp.toString());

          setState(() {
            sharedPreferences.setString(
                "fullName", verfiyOtp.data.name.toString());
            sharedPreferences.setString(
                "mobile", verfiyOtp.data.mobile.toString());
            sharedPreferences.setString(
                "profileImage", verfiyOtp.data.image.toString());
            sharedPreferences.setString(
                "email", verfiyOtp.data.email.toString());

            sharedPreferences.setString(
                "address", verfiyOtp.data.address.toString());
            sharedPreferences.setString(
                "wallet", verfiyOtp.data.amount.toString());

            sharedPreferences..setBool("isSigned", true);
            print(verfiyOtp.data.id.toString());
            isLoading = false;
            id = verfiyOtp.data.id.toString();
            Mobile = verfiyOtp.data.mobile.toString();
            // email = verifyOtpResponse.result.email;
            print(Mobile);
            // print(verifyOtpResponse.message);
            // print(email);
            print(id);
            response = verfiyOtp.status;
            // print("signupResponse of it is:"+ signUpResponse)
          });
        } else {
          print("error or data not found");
        }
      }
    }
    // else{
    //   mobile=widget.mobileNo;
    //   if (widget.otpData==loginOtpController.text){
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => MyNavigationBar()),
    //     );
    //   }
    //   else{
    //     print('otp didnot verify');
    //     print(loginOtpController.text);
    //     print(widget.otpData);
    //     print(widget.mobileNo);
    //   }
    // }
  }

  //init
  @override
  void initState() {
    print("ravan your otp is ${widget.otpData}");
    print("ravan your number  is ${widget.phone}");
    // signInWithPhone(context);
    super.initState();
  }

  //signinfun
  // Future<void> signInWithPhone(BuildContext context) async {
  //   print(widget.num);
  //   fauth.verifyPhoneNumber(
  //       phoneNumber: widget.num,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         UserCredential cred = await fauth.signInWithCredential(credential);
  //         if (cred.user != null) {
  //           Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(builder: (context) => HomeScreen()),
  //                   (route) => false);
  //         }
  //       },
  //       verificationFailed: (verificationFailed) {},
  //       codeSent: (verificationID, resendToken) {
  //         this.verificationId = verificationID;
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) async {});
  // }

  @override
  Widget build(BuildContext context) {
    // userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Center(
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextFormField(
                  controller: _otpController,
                  autocorrect: true,
                  validator: (text) {
                    if (!(text.length == 4) && text.isNotEmpty) {
                      return "Enter Valid 6 digit OTP No";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    labelText: "OTP",
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
                  onPressed: () => _VerifyLoginOtp(),
                  // onPressed: () async {
                  //   try {
                  //     UserCredential cred = await fauth.signInWithCredential(
                  //         PhoneAuthProvider.credential(
                  //             verificationId: verificationId,
                  //             smsCode: _otpController.text));
                  //
                  //     if (cred.user != null) {
                  //       userProvider.setphonenumber(widget.num);
                  //       userProvider.setstutus("logged in");
                  //       Navigator.pushAndRemoveUntil(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => HomeScreen()),
                  //               (route) => false);
                  //     }
                  //   } catch (e) {
                  //     print(e.toString());
                  //     SnackBar snackBar = SnackBar(content: Text('Invalid OTP'));
                  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //   }
                  //   //GOTO homescreen
                  //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  // },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
