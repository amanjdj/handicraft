import 'package:flutter/material.dart';
import 'package:handicraft/sidebar_navigation/navigation_bloc.dart';

class OrdersPage extends StatelessWidget  with NavigationStates{
  // const OrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Orders',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
