import 'package:handicraft/sellerhome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handicraft/customerhome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String email;
  Register({Key key, @required this.name,this.imageUrl,this.email}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _number;
  String _role="customer";
  SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              child: Image.network(widget.imageUrl),
            ),
            Text("Hello"+widget.name),
            Text(widget.email),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Add Number",
              ),
              onChanged: (value){
                setState(() {
                  _number=value;
                });
              },
            ),
            Text("Choose ur role"),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                      color: _role=='seller'?Colors.lightBlueAccent:Colors.white,
                      child: Text("Seller")),
                  onTap: (){
                    setState(() {
                      _role='seller';
                    });
                  },
                ),
                SizedBox(width: 20,),
                GestureDetector(

                  onTap: (){
                   setState(() {
                     _role="customer";
                   });
                  },
                  child: Container(
                      color: _role=='customer'?Colors.lightBlueAccent:Colors.white,
                      child: Text("Customer")),
                )
              ],
            ),
            ElevatedButton(onPressed: (){

              void _register()async{
                await FirebaseFirestore.instance.collection("users").doc(widget.email).set({
                  "email":widget.email,
                  "phone":_number,
                  "type":_role
                }).whenComplete((){
                  sharedPreferences.setString("type", _role);
                  sharedPreferences.setString("mail", widget.email);
                  if(_role=='seller'){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerHome()));
                  }
                  else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerHome()));
                  }
                });
              }
              _register();
            }, child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
