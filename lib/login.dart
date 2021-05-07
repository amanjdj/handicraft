import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handicraft/pages/customerhome.dart';
import 'package:handicraft/home.dart';
import 'package:handicraft/register.dart';
import 'package:handicraft/sellerhome.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handicraft/sidebar/sidebar_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_background/animated_background.dart';
import 'package:handicraft/splashScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  String type;
  // SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedBackground(
        vsync:this,
        behaviour: BubblesBehaviour(),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Container(
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage("images/logo.png"),
               )
             ),
             height: height*0.2,
             width: height*0.2,
           ),
           SizedBox(height: 20,),
           Center(
             child: Container(
               height: height*0.09,
               width: width*0.6,
               child: ElevatedButton(onPressed: (){
                 void signIn()async{
                   // final GoogleSignInAccount account=
                   await _googleSignIn.signIn().then((value) async {
                     print(_googleSignIn.currentUser.displayName);
                     var data =await FirebaseFirestore.instance.collection("users").where("email",isEqualTo: _googleSignIn.currentUser.email).get();
                     if(data.docs.isNotEmpty){
                       data.docs.forEach((element) async {
                         type=element.data()["type"];
                         // sharedPreferences ??= await SharedPreferences.getInstance();
                         await App.sharedPreferences.setString("type", type);
                         await App.sharedPreferences.setString("email", _googleSignIn.currentUser.email);
                         await App.sharedPreferences.setString("url", _googleSignIn.currentUser.photoUrl);
                         await App.sharedPreferences.setString("name", _googleSignIn.currentUser.displayName);

                         if(type=="seller"){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerHome()));
                         }
                         else if(type=="customer"){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SidebarLayout()));
                         }
                       });
                     }
                     else if(data.docs.isEmpty){
                       // sharedPreferences ??= await SharedPreferences.getInstance();
                       await App.sharedPreferences.setString("type", "null");
                       await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register(name: _googleSignIn.currentUser.displayName,imageUrl: _googleSignIn.currentUser.photoUrl,email: _googleSignIn.currentUser.email,)));
                       print("empty");
                     }
                   });//google sign
                   // final GoogleSignInAuthentication authentication =
                   // await account.authentication;
                   //
                   // final GoogleAuthCredential credential = GoogleAuthProvider.credential(
                   //     idToken: authentication.idToken,
                   //     accessToken: authentication.accessToken);
                   //
                   // final UserCredential authResult =
                   // await _auth.signInWithCredential(credential);
                   // final User user = authResult.user;
                   //
                   // print(user);

                 }
                 signIn();
               }, child: Text("Sign in using Google",style: TextStyle(fontSize: 20),)),
             ),
           ),

         ],
       ),
      )
    );
  }
}
