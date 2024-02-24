import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class manage_plant extends StatefulWidget {
  const manage_plant({super.key});

  @override
  State<manage_plant> createState() => _manage_plantState();
}

class _manage_plantState extends State<manage_plant> {
  TextEditingController _searchController = TextEditingController();
  String SeasonType = 'Summer';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Season',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF86A7FC))),
                  onPressed: () {
                    setState(() {
                      SeasonType = 'Winter';
                    });
                  },
                  icon: Image.asset(
                    'icons/winter.png',
                    height: 50,
                    width: 50,
                  ),
                  label: Text(
                    'winter'.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFCEDEBD))),
                  onPressed: () {
                    setState(() {
                      SeasonType = 'Spring';
                    });
                  },
                  icon: Image.asset(
                    'icons/spring.png',
                    height: 50,
                    width: 50,
                  ),
                  label: Text(
                    'spring'.toUpperCase(),
                    style: TextStyle(color: Colors.black),
                  )),
              TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFFFDD95))),
                  onPressed: () {
                    setState(() {
                      SeasonType = 'Summer';
                    });
                  },
                  icon: Image.asset(
                    'icons/summer.png',
                    height: 50,
                    width: 50,
                  ),
                  label: Text(
                    'Summer'.toUpperCase(),
                    style: TextStyle(color: Colors.black),
                  )),
              TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFFF9800))),
                  onPressed: () {
                    setState(() {
                      SeasonType = 'Autumn';
                    });
                  },
                  icon: Image.asset(
                    'icons/autumn.png',
                    height: 50,
                    width: 50,
                  ),
                  label: Text(
                    'autumn'.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: SeasonType.isNotEmpty
              ? FirebaseFirestore.instance
                  .collection('Plants')
                  .doc('All_Seasons')
                  .collection('$SeasonType')
                  .snapshots()
              : Stream.empty(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin: EdgeInsets.only(top: 100),
                child: SpinKitCircle(
                  color: Colors.green,
                  size: 80,
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot plant = snapshot.data!.docs[index];
                  final ID = plant.id;
                  return ListTile(
                    leading: Text("ID: ${plant['Plant_ID']}"),
                    title: Text("Name: ${plant['Plant_Name']}"),
                    subtitle: Text("Price: ${plant['Plant_Price']}"),
                    trailing: IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('Plants')
                              .doc('All_Seasons')
                              .collection(SeasonType)
                              .doc('$ID')
                              .delete();
                        },
                        icon: Icon(Icons.delete)),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
