import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handicraft/splashScreen.dart';

class CustomerCart extends StatefulWidget {
  final List<String> cartCount;
  CustomerCart({this.cartCount});

  @override
  _CustomerCartState createState() => _CustomerCartState();
}

class _CustomerCartState extends State<CustomerCart> {

  List<CartCard> cartItems=[];

  void getCartItems()async{
    for(int i=0;i<widget.cartCount.length;i++){
      var data=await FirebaseFirestore.instance.collection("Items").doc(widget.cartCount[i]).get();
      CartCard cart=CartCard(title: data.data()['title'],price: data.data()['price'],itemID: data.id);
      cartItems.add(cart);
      totalPrice=totalPrice+double.parse(data.data()['price']);
    }
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    getCartItems();
  }
  double totalPrice=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Total Cart Value: "+totalPrice.toString()),
              SizedBox(height: 10,),
              Expanded(
                child:Container(
                  child: cartItems.length==0?Text("Cart Empty"):ListView.builder(itemCount:cartItems.length,itemBuilder: (_,index){
                    return CartItems(context,cartItems[index].title, cartItems[index].price, cartItems[index].itemID);
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget CartItems(BuildContext context,String title,String price,String itemID){
    return Card(
      child: Container(
        color: Colors.lightBlueAccent,
        child: Column(
          children: [
            Text(title),
            Text(price.toString()),
            ElevatedButton(onPressed: (){
              void remove()async{
                widget.cartCount.remove(itemID);
                // setState(() {
                  cartItems.removeWhere((element) => element.itemID==itemID);
                  setState(() {
                  });
                // });
                await FirebaseFirestore.instance.collection("users").doc(App.sharedPreferences.getString("email")).update({
                  "cart":widget.cartCount
                }).then((value){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Removed from cart")));
                });
              }
              remove();
            }, child: Text("Remove"))
          ],
        ),
      ),
    );
}
}

class CartCard{
  String title,price,itemID;
  CartCard({this.title,this.price,this.itemID});
}