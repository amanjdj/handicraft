import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handicraft/delivery_page.dart';
import 'package:handicraft/sidebar_navigation/navigation_bloc.dart';
import 'package:handicraft/splashScreen.dart';

class OrdersPages extends StatelessWidget  with NavigationStates{
  String imageUrl,title,price,desc,itemID,seller;
  List<String> cartList;

  OrdersPages(this.imageUrl,this.title,this.price,this.desc,this.itemID,this.seller,this.cartList);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double size2 =  size.width * 0.6;
    return Scaffold(
      backgroundColor: Color(0xff44a7c4),
      appBar: AppBar(
        backgroundColor: Color(0xff44a7c4),
        elevation: 0,
        leading: CloseButton(),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.35),
                    padding: EdgeInsets.only(top: size.height *0.08, left: 15,right: 15),
                    // height: size.height * 0.55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          padding: EdgeInsets.only(left: 10),
                          height: size.height * 0.25,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.black,
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(desc,
                              style: TextStyle(height: 1.5),
                            ),
                          ),
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              // margin: EdgeInsets.only(right: 15),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Colors.black,
                                )
                              ),
                              child: IconButton(
                                color: Color(0xff44a7c4),
                                icon: Icon(Icons.add_shopping_cart),
                                onPressed: (){
                                void addToCart()async{
                                  if(cartList.contains(itemID)){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item already added")));}
                                  else{
                                    cartList.add(itemID);
                                    await FirebaseFirestore.instance.collection("users").doc(App.sharedPreferences.getString("email")).update({
                                      "cart":cartList
                                    }).then((value){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Added to cart")));
                                    });
                                  }
                                }
                                addToCart();
                                },
                                  // child: Text("Add to cart")
                                ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: SizedBox(
                                  height: 50,
                                  width: size.width * 0.72,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: size.width * 0.3)),
                                        backgroundColor: MaterialStateProperty.all(Color(0xff44a7c4)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  // side: BorderSide(color: Colors.)
                                              ),
                                          ),
                                      ),
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryPage(imageUrl,title,price,desc,itemID,seller)));
                                      },
                                      child: Text("Buy Now"),
                                  )
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: "Price\n"),
                                    TextSpan(
                                      text: "₹ " + price,
                                      style: Theme.of(context).textTheme.headline4.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,fontSize: size2 * 0.09,
                                      ),
                                    ),
                                  ]
                                ),
                            ),
                            // SizedBox(
                            //   width: size.width * 0.1,
                            // ),
                            Container(
                              height: size.height * 0.35,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                height: size.height * 0.35,
                                width: size.width * 0.5,
                                imageUrl: imageUrl,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: EdgeInsets.only(right: 20,left: 20, bottom: 20),
            //     child: Text(title,
            //       style: TextStyle(
            //           color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30, fontFamily: "Pacifico"),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: 200,
            //   decoration: BoxDecoration(
            //     color: Color(0xff44a7c4),
            //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36),bottomRight: Radius.circular(36)),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey,
            //         offset: Offset(0.0, 5),
            //         blurRadius: 6.0,
            //       ),
            //     ],
            //   ),
            //   child: CachedNetworkImage(
            //     imageUrl: imageUrl,
            //     progressIndicatorBuilder: (context, url, downloadProgress) =>
            //         CircularProgressIndicator(value: downloadProgress.progress),
            //     errorWidget: (context, url, error) => Icon(Icons.error),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text("Description", style: Theme.of(context).textTheme.headline4.copyWith(
            //       color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "Pacifico"
            //   ),),
            // ),
            // SingleChildScrollView(
            //   child: Container(
            //     child: Text(desc),
            //   ),
            // ),
            // ElevatedButton(onPressed: (){
            //   void addToCart()async{
            //     if(cartList.contains(itemID)){
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item already added")));
            //     }
            //     else{
            //       cartList.add(itemID);
            //       await FirebaseFirestore.instance.collection("users").doc(App.sharedPreferences.getString("email")).update({
            //         "cart":cartList
            //       }).then((value){
            //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Added to cart")));
            //       });
            //     }
            //
            //   }
            //   addToCart();
            // }, child: Text("Add to cart"))
          ],
        ),
      ),
    );
  }
}
