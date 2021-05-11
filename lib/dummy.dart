// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DataFetch extends StatefulWidget {
//   const DataFetch({Key key}) : super(key: key);
//   @override
//   _DataFetchState createState() => _DataFetchState();
// }
// class _DataFetchState extends State<DataFetch> {
//   List<Model> list=[];
//   void fetchData()async{
//     var data=await FirebaseFirestore.instance.collection("Items").get();
//     print(data.docs.length);
//     for(int i=0;i<data.docs.length;i++){
//       print(data.docs[i].data()['price']);
//       Model model=Model(data.docs[i].data()['title'], data.docs[i].data()['price'],data.docs[i].data()['imageURL'],data.docs[i].data()['desc'], data.docs[i].data()['seller']);
//       list.add(model);
//     }
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: list.length==0? Center(child: Text("No Post")):ListView.builder(itemCount: list.length,
//             itemBuilder:(_,index){
//               return MyUI(list[index].title, list[index].url, list[index].price, list[index].desc, list[index].seller);
//             } ,
//           ),
//         ),
//       ),
//     );
//   }
//   Widget MyUI(String title,String url,String price,String desc,String seller){
//     return Container(
//       child: Column(
//         children: [
//           Text(title),
//           Image.network(url),
//           Text(price),
//           Text(desc),
//           Text(seller)
//         ],
//       ),
//     );
//   }
// }
//
// class Model{
//   String title,price,url,desc,seller;
//   Model(this.title,this.price,this.url,this.desc,this.seller);
// }
