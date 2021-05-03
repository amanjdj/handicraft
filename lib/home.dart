import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handicraft/login.dart';


class Home extends StatefulWidget {
  final String name;
  Home({Key key, @required this.name}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Welcome"),
            Text(widget.name),
            Text("handicraft"),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              _googleSignIn.signOut().then((value){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              });
            }, child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
