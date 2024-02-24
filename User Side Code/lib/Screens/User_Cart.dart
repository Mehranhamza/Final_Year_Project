import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantify/Screens/Auth/login.dart';
import 'package:plantify/Screens/HomeScreen.dart';

class OrderDisplay extends StatelessWidget {
  final FirstCollection = FirebaseFirestore.instance.collection('Orders');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(Icons.skip_previous)),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('plantify'.toUpperCase()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => OrderDisplay()));
              },
              icon: Icon(Icons.shopping_cart)),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),

      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User_Orders')
                .doc('${FirebaseAuth.instance.currentUser!.email}')
                .snapshots(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                var orders = snapshots.data;
                var userdata = orders!.data() as Map<dynamic, dynamic>;
                var userlist = userdata.entries.toList();
                return ListView.builder(
                    itemCount: userlist.length,
                    itemBuilder: (context, index) {
                      var orderEntry = userlist[index];
                      var orderID = orderEntry.key;
                      var orderData = orderEntry.value as Map<String, dynamic>;
                      return Card(
                        child: ListTile(
                          title: Text('Order-ID: ${orderData['Order_ID']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('User Email: ${orderData['User_Email']}'),
                              Text('Plant Name: ${orderData['Plant_Name']}'),
                              Text(
                                  'Total Quantity: ${orderData['Total_Quantity']}'),
                              Text('Total Price: ${orderData['Total_Price']}'),
                              orderData['Order_Status'] == true
                                  ? Row(
                                      children: [
                                        Text('Order Status'),
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                color: Colors.green.shade900,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              'Accepted',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text('Order Status'),
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                color: Colors.red.shade900,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              'Pending',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Text('data');
              }
            }),
      ),

      // body: Container(
      //   height: MediaQuery.of(context).size.height * 0.88,
      //   child: StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection('Orders')
      //         .doc('${FirebaseAuth.instance.currentUser!.email}')
      //         .snapshots(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(child: CircularProgressIndicator());
      //       } else if (snapshot.hasError) {
      //         return Text('Error: ${snapshot.error}');
      //       } else if (!snapshot.hasData || snapshot.data == null) {
      //         return Text('No Data');
      //       } else {
      //         var orderData = snapshot.data!.data();

      //         return ListView.builder(
      //           itemCount: 1, // Since there is only one document
      //           itemBuilder: (context, index) {
      //             return Card(
      //               child: SingleChildScrollView(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: orderData!.entries.map((entry) {
      //                     var key = entry.key;
      //                     var doc = entry.doc;

      //                     return Container(
      //                       margin: EdgeInsets.only(bottom: 30),
      //                       decoration: BoxDecoration(border: Border.all()),
      //                       child: ListTile(
      //                         title: Text('Order-ID: ${doc['Order_ID']}'),
      //                         subtitle: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Text('User Email: ${doc['User_Email']}'),
      //                             Text('Plant Name: ${doc['Plant_Name']}'),
      //                             Text(
      //                                 'Total Quantity: ${doc['Total_Quantity']}'),
      //                             Text('Total Price: ${doc['Total_Price']}'),
      //                             doc['Order_Status'] == true
      //                                 ? Row(
      //                                     children: [
      //                                       Text('Order Status'),
      //                                       Container(
      //                                           padding: EdgeInsets.all(4),
      //                                           decoration: BoxDecoration(
      //                                               color:
      //                                                   Colors.green.shade900,
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       10)),
      //                                           child: Text(
      //                                             'Accepted',
      //                                             style: TextStyle(
      //                                                 color: Colors.white),
      //                                           )),
      //                                     ],
      //                                   )
      //                                 : Row(
      //                                     children: [
      //                                       Text('Order Status'),
      //                                       Container(
      //                                           padding: EdgeInsets.all(4),
      //                                           decoration: BoxDecoration(
      //                                               color: Colors.red.shade900,
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       10)),
      //                                           child: Text(
      //                                             'Pending',
      //                                             style: TextStyle(
      //                                                 color: Colors.white),
      //                                           )),
      //                                     ],
      //                                   )
      //                           ],
      //                         ),
      //                       ),
      //                     );
      //                   }).toList(),
      //                 ),
      //               ),
      //             );
      //           },
      //         );
      //       }
      //     },
      //   ),
      // ),
    );
  }
}


//  itemCount: orderData.length,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot doc = orderData[index];
//                     Map<dynamic, dynamic> emailData =
//                         doc.data() as Map<dynamic, dynamic>;

//                     List<Widget> orderListTiles = emailData.entries.map((e) {
//                       var id = e.key;
//                       var data = e.doc as Map<dynamic, dynamic>;

//                       // Create a ListTile for each order
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         child: Card(
//                           borderOnForeground: true,
//                           shadowColor: Colors.green,
//                           elevation: 20,
//                           child: ListTile(
//                             title: Text('Order ID: ${data['Order_ID']}'),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Plant Name: ${data['Plant_Name']}'),
//                                 Text(
//                                     'Total Quantity: ${data['Total_Quantity']}'),
//                                 Text('Total Price: ${data['Total_Price']}'),
//                                 data['Order_Status'] == true
//                                     ? Row(
//                                         children: [
//                                           Text('Order Status'),
//                                           Container(
//                                               padding: EdgeInsets.all(4),
//                                               decoration: BoxDecoration(
//                                                   color: Colors.green.shade900,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10)),
//                                               child: Text(
//                                                 'Accepted',
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               )),
//                                         ],
//                                       )
//                                     : Row(
//                                         children: [
//                                           Text('Order Status'),
//                                           Container(
//                                               padding: EdgeInsets.all(4),
//                                               decoration: BoxDecoration(
//                                                   color: Colors.red.shade900,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10)),
//                                               child: Text(
//                                                 'Pending',
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               )),
//                                         ],
//                                       )
//                               ],
//                             ),
//                             // Customize your ListTile based on the order data
//                             // Add additional Text, Icons, or other widgets as needed
//                           ),
//                         ),
//                       );
//                     }).toList();

//                     return Column(
//                       children: orderListTiles,
//                     );