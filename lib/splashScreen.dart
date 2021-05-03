import 'dart:async';
import '';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handicraft/login.dart';
import 'package:handicraft/sellerhome.dart';
import 'package:handicraft/customerhome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  String type;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    displaySplash();
  }
  void displaySplash()async{
    sharedPreferences ??= await SharedPreferences.getInstance();
    print(sharedPreferences.getString("type"));
    print(sharedPreferences.getString("email"));
    Timer(Duration(seconds: 5),()async{
      if(await _googleSignIn.isSignedIn()){
        String type=await sharedPreferences.getString("type");
        if(type=='seller'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(SellerHome())));
        }
        else if(type=='customer'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(CustomerHome())));
        }
        else{
          print("something wrong");
        }
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(Login())));
        print("user null");
        print(type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body:Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                image:DecorationImage(
                    image: AssetImage("images/splash.jpg"),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(
            child: Center(child: Text("Handicraft",style: TextStyle(fontSize: height*0.08,fontFamily: "Pacifico"),)),
            decoration: BoxDecoration(
                   color: Colors.white54,
              borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(top:height*0.15 ),
            height: 100,
            width: width*0.8,

          )
        ],
      ),
    );
  }
}
