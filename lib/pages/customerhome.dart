import 'package:handicraft/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handicraft/sidebar_navigation/navigation_bloc.dart';
class CustomerHome extends StatelessWidget with NavigationStates{
  GoogleSignIn _googleSignIn=GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome Customer"),
              // ElevatedButton(onPressed: (){
              //   void logout()async{
              //     await _googleSignIn.signOut().whenComplete((){
              //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              //     });
              //   }
              //   logout();
              // }, child:Text("Logout") )
            ],
          ),
        ),
      ),
    );
  }
}
