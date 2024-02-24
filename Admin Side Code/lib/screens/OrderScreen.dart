import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllEmails extends StatefulWidget {
  const AllEmails({super.key});

  @override
  State<AllEmails> createState() => _AllEmailsState();
}

class _AllEmailsState extends State<AllEmails> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('User_Orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var emails = snapshot.data!.docs;

            return ListView.builder(
                itemCount: emails.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docs = emails[index];

                  return ExpansionTile(
                      title: Text('${docs.id}'),
                      children: (docs.data() as Map<dynamic, dynamic>)
                              .entries!
                              .map((e) {
                            var id = e.key;
                            var data = e.value as Map<dynamic, dynamic>;
                            return ExpansionTile(
                              title: Text('$id'),
                              children: [
                                ListTile(
                                  title:
                                      Text('Plant_Name: ${data['Plant_Name']}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Plant-Name: ${data['Plant_Name']}'),
                                      Text('Plant-ID: ${data['Plant_Name']}'),
                                      Text('User_Email: ${data['User_Email']}'),
                                      Text(
                                          'User_Address: ${data['User_Address']}'),
                                      Text('User_Phone: ${data['User_Phone']}'),
                                      Text(
                                          'Total_Quantity: ${data['Total_Quantity']}'),
                                      Text(
                                          'Total_Price: ${data['Total_Price']}'),
                                      Row(
                                        children: [
                                          Text('Order_Status:'),
                                          data['Order_Status'] == true
                                              ? Container(
                                                  color: Colors.green.shade900,
                                                  child: Text(
                                                    'Accepted',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : Container(
                                                  color: Colors.red.shade900,
                                                  child: Text(
                                                    'Pending',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('User_Orders')
                                                    .doc('${docs.id}')
                                                    .update({
                                                  '$id.Order_Status': true
                                                });

                                                Get.snackbar('Order Accepted',
                                                    'Payment Successfull',
                                                    backgroundColor:
                                                        Colors.green,
                                                    colorText: Colors.white,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM);
                                              },
                                              child: Text('Accept')),
                                          ElevatedButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('User_Orders')
                                                    .doc('${docs.id}')
                                                    .update({
                                                  '$id.Order_Status': false
                                                });
                                                Get.snackbar('Order Rejected',
                                                    'Payment UnSuccessfull',
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM);
                                              },
                                              child: Text('Reject'))
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }).toList() ??
                          []);
                });
          } else {
            return Text('No Data');
          }
        });
  }
}
