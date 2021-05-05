// import 'package:flutter/material.dart';
//
// class CustomInput extends StatelessWidget {
//   const CustomInput({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: 50,
//             child: ClipOval(child: Image.network(widget.imageUrl,fit: BoxFit.cover,)),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 color: Color(0xff2c98f0),
//                 borderRadius: BorderRadius.circular(20)
//             ),
//             padding: EdgeInsets.all(10),
//             height: height*0.5,
//             width: width*0.7,
//             child: Center(
//               child: Column(
//                 children: [
//                   Text("Hello "+widget.name),
//                   Text(widget.email),
//                   TextFormField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       hintText: "Add Number",
//                     ),
//                     onChanged: (value){
//                       setState(() {
//                         _number=value;
//                       });
//                     },
//                   ),
//                   Text("Choose ur role"),
//                   Row(
//                     children: [
//                       GestureDetector(
//                         child: Container(
//                             color: _role=='seller'?Colors.lightBlueAccent:Colors.white,
//                             child: Text("Seller")),
//                         onTap: (){
//                           setState(() {
//                             _role='seller';
//                           });
//                         },
//                       ),
//                       SizedBox(width: 20,),
//                       GestureDetector(
//
//                         onTap: (){
//                           setState(() {
//                             _role="customer";
//                           });
//                         },
//                         child: Container(
//                             color: _role=='customer'?Colors.lightBlueAccent:Colors.white,
//                             child: Text("Customer")),
//                       )
//                     ],
//                   ),
//                   ElevatedButton(onPressed: (){
//
//                     void _register()async{
//                       await FirebaseFirestore.instance.collection("users").doc(widget.email).set({
//                         "email":widget.email,
//                         "phone":_number,
//                         "type":_role
//                       }).whenComplete((){
//                         sharedPreferences.setString("type", _role);
//                         sharedPreferences.setString("mail", widget.email);
//                         if(_role=='seller'){
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerHome()));
//                         }
//                         else{
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerHome()));
//                         }
//                       });
//                     }
//                     _register();
//                   }, child: Text("Submit"))
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
