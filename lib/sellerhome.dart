import 'package:handicraft/addselleritems.dart';
import 'package:handicraft/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:animated_background/animated_background.dart';
import 'package:handicraft/sellerhomewidgets.dart';
import 'package:handicraft/dummy.dart';
class SellerHome extends StatefulWidget {
  @override
  _SellerHomeState createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> with TickerProviderStateMixin{
  GoogleSignIn _googleSignIn=GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(0xff2c98f0),
        color: Color(0xff2c98f0),
        index: 0,
        items: <Widget>[
          Icon(Icons.home,size: 20,color: Colors.white,),
          Icon(Icons.edit,size: 20,color: Colors.white,),
          IconButton(icon: Icon(Icons.power_settings_new,size: 20,color: Colors.white,), onPressed: (){void logout()async{
            await _googleSignIn.signOut().whenComplete((){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
            });
          }
          logout();})
        ],
        onTap: (index){
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: AnimatedBackground(
        behaviour: RacingLinesBehaviour(),
        vsync: this,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            OrdersArrived(),
            ItemModify()
          ],
          onPageChanged: (int index){
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddItemsBySeller()));
        },
      ),
    );
  }
}
