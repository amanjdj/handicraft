import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handicraft/sidebar_navigation/navigation_bloc.dart';
import 'package:handicraft/splashScreen.dart';

class OrdersPage extends StatelessWidget  with NavigationStates{
  void getCustomerData()async{
    var data=await FirebaseFirestore.instance.collection("Orders").get();
    for(int i=0;i<data.docs.length;i++){
      if(data.docs[i]['customer']==App.sharedPreferences.getString("email")){
        print(data.docs[i]['price']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff44a7c4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff44a7c4),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment(1,-1),
              child: Text("My Orders",
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Orders").where("customer",isEqualTo: App.sharedPreferences.getString("email")).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                Widget fetchWidget(AsyncSnapshot<QuerySnapshot> streamSnapshot){
                  if(!streamSnapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  else{
                    if(streamSnapshot.data.docs.length==0){
                      return Center(child: Text("No Orders",
                        style: TextStyle(color: Colors.white,fontSize: 50),
                      ));
                    }
                    else{
                      return ListView.builder(
                        itemCount: streamSnapshot.data.docs.length,
                        itemBuilder: (_, index) {
                          return OrdersContainer(context,
                            streamSnapshot.data.docs[index].id,
                            streamSnapshot.data.docs[index]['title'],
                            streamSnapshot.data.docs[index]['price'],
                            streamSnapshot.data.docs[index]['status'],
                            streamSnapshot.data.docs[index]['time'],
                          );
                        },
                      );
                    }
                  }
                }
                return fetchWidget(streamSnapshot);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget OrdersContainer( BuildContext context, String orderNo, String itemId,String price, String status,Timestamp date) {
     Size size = MediaQuery.of(context).size;
    return Padding(
          padding: const EdgeInsets.only(top: 15,left: 8,right: 8,bottom: 8),
          child: Container(
            height: size.height * 0.3,
            width: size.width * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 5),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Order No: " + orderNo,
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(date.toDate().day.toString() + date.toDate().month.toString() + date.toDate().year.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 15),
                      child: Text("Item Name: ",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(itemId,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25,top: 10),
                      child: Text("Total Amount: ",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,right: 10,bottom: 25),
                      child: Text("₹" + price,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){},
                        child: Container(
                          // margin: EdgeInsets.only(right: 15),
                          height: 45,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(
                                color: Colors.black,
                              )
                          ),
                            child: Center(child: Text("Details",
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                            )),
                          ),
                      )
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(status,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),

          ),
        );
  }
}
