import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App_Permission extends StatefulWidget {
  const App_Permission({super.key});

  @override
  State<App_Permission> createState() => _App_PermissionState();
}

class _App_PermissionState extends State<App_Permission> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('AppPermission').snapshots(),
        builder: (context, snpashots) {
          if (snpashots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snpashots.hasData) {
            var data = snpashots.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = data[index];
                  var docID = doc.id;
                  return ListTile(
                    title: doc['App_Permission'] == true
                        ? Container(
                            color: Colors.green.shade900,
                            child: Text(
                              'App is ON',
                              style: TextStyle(color: Colors.white),
                            ))
                        : Container(
                            color: Colors.red.shade900,
                            child: Text(
                              'App is OFF',
                              style: TextStyle(color: Colors.white),
                            )),
                    subtitle: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              CollectionReference database = FirebaseFirestore
                                  .instance
                                  .collection('AppPermission');
                              database
                                  .doc('$docID')
                                  .update({'App_Permission': true});

                              Get.snackbar('Congratulations', 'App is On',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.green.shade900);
                            },
                            child: Text('Turn On App')),
                        ElevatedButton(
                            onPressed: () {
                              CollectionReference database = FirebaseFirestore
                                  .instance
                                  .collection('AppPermission');
                              database
                                  .doc('$docID')
                                  .update({'App_Permission': false});

                              Get.snackbar('Oops', 'App is off',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red.shade900);
                            },
                            child: Text('Turn off App'))
                      ],
                    ),
                  );
                });
          } else {
            return Text('No Data');
          }
        });
  }
}
