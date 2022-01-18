import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/model/verfityOtp.dart';
import 'package:grocery/model/wallet_model.dart';
import 'package:grocery/network/api_call.dart';
import 'package:grocery/screen/addmoney.dart';
import 'package:grocery/screen/custom.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class wallet extends StatefulWidget {
  const wallet({Key key}) : super(key: key);

  @override
  _walletState createState() => _walletState();
}

class _walletState extends State<wallet> {
  String userwallet="0";
  String id;


  Razorpay _razorpay;
  Future<WalletResponse> _future;


  @override
  void initState() {
    getvalidationData();


    // TODO: implement initState
    super.initState();

  }

  circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }



  Future getvalidationData() async {

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('user_id');
    var amount=sharedPreferences.getString('wallet');
    setState(() async {

      WalletResponse walletResponse =
          await ApiCall.user_wallet_amount(id);
      if (walletResponse == null) {
     //   circularProgress();
        print('data not  sent or error');
      } else {
        if (walletResponse.responce==true) {

          // print('hello rvn kaisa ho${walletResponse.data[0].amount}');
          //
          // print(userwallet);
          setState(() {

            userwallet=walletResponse.data[0].amount ==null  ?userwallet :walletResponse.data[0].amount;
          });

        }else{
          circularProgress();

        }
      }

     // _future =  ApiCall.user_wallet_amount(id);
     // _future = ApiCall.personal_cart(user_id);
    });
    print(id);
  }

  String Response;
  String orderID;
  String total="1885";
  String mobile;
  String email="akyadav9155@gmail.com";




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Your Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text('Current Balance',style: TextStyle(
                      fontSize: 18,

                    ),),
                  ),
                 Container(
                   child: Text(userwallet ,style: TextStyle(
                     fontSize: 18,

                   ),),
                 )

                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => addmoney(),
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 200,
                    child: Center(
                        child: Text(
                          'add money',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
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
