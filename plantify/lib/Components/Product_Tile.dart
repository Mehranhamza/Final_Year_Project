import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:plantify/Screens/Product_Info.dart';

class ProductTile extends StatefulWidget {
  const ProductTile({super.key});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Plants')
            .doc('All_Seasons')
            .collection('Summer')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitDualRing(color: Colors.green),
            );
          }
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot Plant = data[index];
                  String? PlantID = Plant.id;
                  String? PlantImage = "${Plant['Plant_Image_URL']}";
                  String? PlantName = "${Plant['Plant_Name']}";
                  int? PlantPrice = Plant['Plant_Price'];
                  String? PlantDesc = "${Plant['Plant_Description']}";
                  String? ModelURL = "${Plant['Model_URL']}";

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: MediaQuery.of(context).size.height * 0.17,
                    // color: Colors.blue,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Product_Info(
                                      PlantID: PlantID,
                                      index: index,
                                      PlantName: PlantName,
                                      PlantDesc: PlantDesc,
                                      PlantImage: PlantImage,
                                      PlantPrice: PlantPrice,
                                      ModelURL: ModelURL,
                                    ))));
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              top: 0,
                              bottom: 20,
                              child: Hero(
                                  tag: 'Plant_Image_$index',
                                  child: Image.network(PlantImage))),
                          Positioned(
                              left: -10,
                              top: 0,
                              child: Image.asset('assets/Images/SummerSale.png',
                                  height: 80, width: 80)),
                          Positioned(
                              top: 80,
                              left: 10,
                              child: Text(
                                '$PlantName'.toUpperCase(),
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              )),
                          Positioned(
                            left: 2,
                            bottom: 2,
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade700,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(20))),
                                  child: Center(
                                    child: Text(
                                        'Price: $PlantPrice-PKR'.toUpperCase(),
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Text('No Data');
          }
        });
  }
}
