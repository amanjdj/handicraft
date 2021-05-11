import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:handicraft/data/data.dart';
import 'package:handicraft/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handicraft/pages/myorderspage.dart';
import 'package:handicraft/sidebar_navigation/navigation_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../orderpages.dart';
class CustomerHome extends StatefulWidget with NavigationStates{
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  List<Data> dataList = [];


  GoogleSignIn _googleSignIn=GoogleSignIn();

  void fetchData()async{
    var data=await FirebaseFirestore.instance.collection("Items").get();
    print(data.docs.length);
    for(int i=0;i<data.docs.length;i++){
      print(data.docs[i].data()['price']);
      Data model=Data(data.docs[i].data()['title'], data.docs[i].data()['price'],data.docs[i].data()['imageURL'],data.docs[i].data()['desc'], data.docs[i].data()['seller']);
      dataList.add(model);
    }
    setState(() {
      print("Working");
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.2,
          decoration: BoxDecoration(
            color: Color(0xff44a7c4),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36),bottomRight: Radius.circular(36)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 5),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Welcome !..", style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold
              ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: 25,
              bottom: 25,
          ),
          height: 24,
          child: Stack(
            children: [
              Text("Featured Products",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  height: 7,
                  color: Color(0xff44a7c4).withOpacity(0.3),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: dataList.length==0? Center(child: Text("Loading...")): ListView.builder(itemCount: dataList.length,scrollDirection: Axis.vertical,
                itemBuilder:(_,index){
                  return FeaturedProductss(dataList[index].url, dataList[index].title, dataList[index].price,(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>(OrdersPages(dataList[index].url, dataList[index].title, dataList[index].price,dataList[index].desc))));
                  });
                }
            ),
          ),
        )
      ],
    );
  }

  Widget FeaturedProductss(String imageUrl, String title, String price,Function press) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.all(20),
        width: size.width*0.7,
        // height: size.height*0.4,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 5),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(title,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),fontSize: 18, fontWeight: FontWeight.bold
                    ),
                  ),
                  Spacer(),
                  Text("₹ " + price,
                    style: TextStyle(
                        color: Color(0xff44a7c4),fontSize: 18, fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class FeaturedProducts extends StatelessWidget {
//   const FeaturedProducts({
//     Key key, this.image, this.title, this.price, this.onPress,
//   }) : super(key: key);
//
//   final String image,title, price;
//   final Function onPress;
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: onPress,
//       child: Container(
//         margin: EdgeInsets.all(20),
//         width: size.width*0.7,
//         // height: size.height*0.4,
//         child: Column(
//           children: [
//             Image.network(image),
//           Container(
//             padding: EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(10),
//                 bottomRight: Radius.circular(10),
//               ),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey,
//                   offset: Offset(0.0, 5),
//                   blurRadius: 6.0,
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Text("$title",
//                   style: TextStyle(
//                     color: Colors.black.withOpacity(0.5),fontSize: 18, fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 Spacer(),
//                 Text("$price",
//                   style: TextStyle(
//                       color: Color(0xff44a7c4),fontSize: 18, fontWeight: FontWeight.bold
//                   ),
//                 ),
//               ],
//             ),
//           )
//           ],
//         ),
//       ),
//     );
//   }
// }