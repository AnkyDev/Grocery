import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class assiment extends StatefulWidget {
  const assiment({Key key}) : super(key: key);

  @override
  _assimentState createState() => _assimentState();
}

class _assimentState extends State<assiment> {
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  var url='https://airmatch-development.herokuapp.com/api/v2/login';


  login()async{


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              TextField(
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10
                ),
                  controller:email ,
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
                  labelText: "Email",
                  hintText: "Email",
                ),


              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 10
                ),
                controller:password ,
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
                  labelText: "Password",
                  hintText: "Password",
                ),


              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  login();
                },
                child: Container(
                  color: Colors.lightBlue,
                  child: Center(
                    child: Text("Login",style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),),
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
