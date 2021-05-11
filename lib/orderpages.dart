import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handicraft/sidebar_navigation/navigation_bloc.dart';

class OrdersPages extends StatelessWidget  with NavigationStates{
  String imageUrl,title,price,desc;

  OrdersPages(this.imageUrl,this.title,this.price,this.desc);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(icon: Icon(FontAwesomeIcons.chevronLeft), onPressed: () {
                  Navigator.pop(context);
                }
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(right: 20,left: 20, bottom: 20),
                child: Text(title,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30, fontFamily: "Pacifico"),
                ),
              ),
            ),
            Container(
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
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Description", style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "Pacifico"
              ),),
            ),
            SingleChildScrollView(
              child: Container(
                child: Text(desc),
              ),
            )
          ],
        ),
      ),
    );
  }
}
