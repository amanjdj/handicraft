import 'package:flutter/material.dart';
import 'package:handicraft/splashScreen.dart';

class OrdersArrived extends StatelessWidget {
  const OrdersArrived({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(color: Colors.transparent,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Text(App.sharedPreferences.getString("email")),
        ),
      )
      ),
    );
  }
}

class ItemModify extends StatelessWidget {
  const ItemModify({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(color: Colors.transparent,
      child: Text("Item Modify",style: TextStyle(fontSize: 40),),
      ),
    );
  }
}
