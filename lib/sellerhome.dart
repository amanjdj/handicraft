import 'package:handicraft/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SellerHome extends StatelessWidget {
  GoogleSignIn _googleSignIn=GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Welcome seller"),
            ElevatedButton(onPressed: (){
              void logout()async{
                await _googleSignIn.signOut().whenComplete((){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                });
              }
              logout();
            }, child:Text("Logout") )
          ],
        ),
      ),
    );
  }
}
