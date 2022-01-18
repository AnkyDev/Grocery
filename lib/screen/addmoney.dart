import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/model/verfityOtp.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/custom.dart';
import 'package:grocery/screen/wallet.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addmoney extends StatefulWidget {
  const addmoney({Key key}) : super(key: key);

  @override
  _addmoneyState createState() => _addmoneyState();
}

class _addmoneyState extends State<addmoney> {
  Razorpay _razorpay;

  @override
  void initState() {
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

  String id;

  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('user_id');
    var amount=sharedPreferences.getString('wallet');
    setState(() {
      id=userid;

      // _future = ApiCall.personal_cart(user_id);
    });
    print(amount);
  }
  String Response;
  String status;
  String orderID;
  String total="1885";
  String mobile;
  String email="akyadav9155@gmail.com";
  String amount;




  void openwallet() async {
    total = addMoneyController.text..toString();
    print(total);
    var options = {
      'key': 'rzp_test_ACNiLVzWwMtvra',
      'amount': num.parse(total)*100,
      //'amount': total,
      //'name': 'Acme Corp.',
      // 'description': 'Fine T-Shirt',
      //'prefill': {'contact': email, 'email': mobile},
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
    _addAmount();
    Response= response.paymentId;
    orderID=response.orderId;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => wallet(),
      ),
    );
    // Provider.of<Orders>(context,listen: false).addOrder(
    //   cart.items.values.toList(),
    //   cart.totalAmount,
    // );
    // showDialog(context: context,
    //     builder: (BuildContext context){
    //       return CustomDialogBox(
    //         title: "Money added  Successful in wallet",
    //         descriptions: "You will be receiving a confirmation email with order details",
    //         text: "OK",
    //       );
    //     }
    // );


    Fluttertoast.showToast(

        msg: "SUCCESS: " + response.paymentId,timeInSecForIosWeb: 30);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 200
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName, );
  }
  circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
  final TextEditingController addMoneyController = TextEditingController();
  final _form = GlobalKey<FormState>();

  Future<void> _addAmount() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    } else {
      amount = addMoneyController.text..toString();
      VerfiyOtp verfiyOtp = await ApiCall.add_moneyTo_wallet(id,amount);

      if (verfiyOtp == null) {
        circularProgress();
        print('data not  save or error');
      } else {
        if (verfiyOtp.data==true) {
          // print('Welcome ravan dtaat has been save in the data base');

          print(verfiyOtp.data.amount);


          setState(() {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
                content: Text('money Add to wallet sucessfully')));

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
                Container(
                  child: Text('Enter the amount',style: TextStyle(
                    fontSize: 35,
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autocorrect: true,
                    controller: addMoneyController,
                    validator: (text) {
                      if (!(text.length >= 1) && text.isNotEmpty) {
                        return "Please Enter the amount";
                      }
                      return null;
                    },
                    decoration: InputDecoration(

                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(30)),
                      prefixIcon: Icon(Icons.account_balance_wallet),
                      hintText: "Enter the amount",


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
                      openwallet();
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
                        'Process',
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
