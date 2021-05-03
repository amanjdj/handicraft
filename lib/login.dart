import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handicraft/customerhome.dart';
import 'package:handicraft/home.dart';
import 'package:handicraft/register.dart';
import 'package:handicraft/sellerhome.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                signIn()async{
                  // await FirebaseFirestore.instance.collection("users").where("email",isEqualTo: "alok.kvbrp@gmail.com").get().then((value){
                  //   value.docs.forEach((element) {
                  //     type=element.data()["type"];
                  //     // print(element.data()["type"]);
                  //   });
                  // });
                  // print(type);
                  await _googleSignIn.signIn().then((value) async {
                    print(_googleSignIn.currentUser.displayName);
                     var data =await FirebaseFirestore.instance.collection("users").where("email",isEqualTo: _googleSignIn.currentUser.email).get();
                     if(data.docs.isNotEmpty){
                       data.docs.forEach((element) {
                         type=element.data()["type"];
                         if(type=="seller"){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerHome()));
                         }
                         else if(type=="customer"){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerHome()));
                         }
                       });
                     }
                     else if(data.docs.isEmpty){
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register(name: _googleSignIn.currentUser.displayName,imageUrl: _googleSignIn.currentUser.photoUrl,email: _googleSignIn.currentUser.email,)));
                       print("empty");
                     }
                });}
                signIn();
              }, child: Text("Sign in using google")),
              ElevatedButton(onPressed: (){
                void logout()async{
                  await _googleSignIn.signOut();
                }
                logout();
              }, child: Text("Free"))
            ],
          ),
        ),
      ),
    );
  }
}
