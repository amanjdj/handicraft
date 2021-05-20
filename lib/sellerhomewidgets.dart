import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handicraft/splashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:handicraft/customerCart.dart';
import 'package:handicraft/data/data.dart';
import 'package:handicraft/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
// import '../orderpages.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class OrdersArrived extends StatelessWidget {
  const OrdersArrived({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Text(App.sharedPreferences.getString("email")),
            ),
          )),
    );
  }
}

class ItemModify extends StatefulWidget {
  const ItemModify({Key key}) : super(key: key);

  @override
  _ItemModifyState createState() => _ItemModifyState();
}

class _ItemModifyState extends State<ItemModify> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.white38,
        child: Column(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                  color: Color(0xff2c98f0),
                  height: 50,
                  width: size.width,
                  child: Center(
                    child: Text(
                      "Edit",
                      style: GoogleFonts.pattaya(
                        color: Colors.white,
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Items")
                    .where("seller",
                        isEqualTo: App.sharedPreferences.getString("email"))
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  return !streamSnapshot.hasData
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: streamSnapshot.data.docs.length,
                          itemBuilder: (_, index) {
                            return MyUI(
                                streamSnapshot.data.docs[index]['title'],
                                streamSnapshot.data.docs[index]['price'],
                                streamSnapshot.data.docs[index]['imageURL'],
                                streamSnapshot.data.docs[index].id,
                                streamSnapshot.data.docs[index]['available']
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget MyUI(String title, String price, String url, String id,String status) {
    Size size = MediaQuery.of(context).size;
    final _price = TextEditingController();
    String desc = price;
    return Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 3.4, right: 3.4),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: url,
                imageBuilder: (context, imageProvider) => Container(
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Item:',
                    style: GoogleFonts.koHo(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text(
                    title,
                    style: GoogleFonts.koHo(
                      fontSize: 25,
                      color: Colors.cyan,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Price:",
                    style: GoogleFonts.koHo(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Icon(
                    FontAwesomeIcons.rupeeSign,
                    size: 21.0,
                    color: Colors.cyan,
                  ),
                  Text(
                    price,
                    style: GoogleFonts.koHo(
                      fontSize: 25,
                      color: Colors.cyan,
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Updated Price"),
                controller: _price,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      void update() async {
                        await FirebaseFirestore.instance
                            .collection("Items")
                            .doc(id)
                            .update({"price": _price.text.trim()}).then(
                                (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Price Updated")));
                        });
                      }

                      update();
                    },
                    child: Text('Update'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        void markStockOut() async {
                          await FirebaseFirestore.instance
                              .collection("Items")
                              .doc(id)
                              .update({"available":"stockout"});
                        }
                        void markStockin() async {
                          await FirebaseFirestore.instance
                              .collection("Items")
                              .doc(id)
                              .update({"available":"stockin"});
                        }
                        status=="stockin"?markStockOut():markStockin();
                      },
                      child: Text(status=="stockin"?"Mark out of stock":"Mark stock available")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    void markUpdate() async {
      await FirebaseFirestore.instance
          .collection("Items")
          .doc(id)
          .update({"available":"stockout"});
    }
  }
}
