import 'package:flutter/material.dart';
import 'package:handicraft/sidebar_navigation/navigation_bloc.dart';

class OrdersPage extends StatelessWidget  with NavigationStates{
  // String imageUrl,title, price;
  //
  // OrdersPage(this.imageUrl,this.title,this.price);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Orders',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
