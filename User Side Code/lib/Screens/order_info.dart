import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:plantify/Screens/Auth/login.dart';
import 'package:plantify/Screens/order_status.dart';

class order_info extends StatefulWidget {
  final String? PlantID;
  final String? PlantName;
  final int? TotalQuantity;
  final int? TotalPrice;

  order_info(
      {super.key,
      required this.PlantID,
      required this.PlantName,
      required this.TotalPrice,
      required this.TotalQuantity});

  @override
  State<order_info> createState() => _order_infoState();
}

class _order_infoState extends State<order_info> {
  bool isplaced = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int orderNumber = Random().nextInt(100);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> AddOrder({String? name, String? address, String? phone}) async {
    setState(() {
      isplaced = true;
    });

    String orderId =
        'Order-$orderNumber'; // Use a unique identifier for each order

    await FirebaseFirestore.instance
        .collection('User_Orders')
        .doc('${FirebaseAuth.instance.currentUser!.email}')
        .set({
      orderId: {
        'Order_ID': orderId,
        'Order_Status': false,
        'Plant_Name': widget.PlantName,
        'Plant_ID': widget.PlantID,
        'Total_Quantity': widget.TotalQuantity,
        'Total_Price': widget.TotalPrice,
        'User_Name': name,
        'User_Address': address,
        'User_Phone': phone,
        'User_Email': FirebaseAuth.instance.currentUser!.email,
      }
    }, SetOptions(merge: true));

    setState(() {
      isplaced = false;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Congratulations'.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: Text('Order is placed'.toUpperCase()),
            actions: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Lottie.asset('assets/animation/OrderPlaced.json'),
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green.shade900),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      order_status(
                                PlantID: widget.PlantID,
                                PlantName: widget.PlantName,
                                TotalQuantity: widget.TotalQuantity,
                                TotalPrice: widget.TotalPrice,
                                orderID: orderNumber,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(-1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.approval),
                        label: Text('Check order status'.toUpperCase()))
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset('assets/animation/order.json',
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width * 0.5),
            Card(
              child: ListTile(
                leading: Text(
                  '${widget.PlantID}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Container(
                  child: Row(
                    children: [
                      Text(
                        'Plant Name:\t\t',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${widget.PlantName}'),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Quantity:\t\t',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${widget.TotalQuantity}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Total Price:\t\t',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${widget.TotalPrice}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Order ID:\t\t',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${orderNumber}'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter Your name';
                          }
                        },
                        decoration: InputDecoration(
                            label: Text('Enter your name'.toUpperCase()),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade900)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade900)),
                            icon: FaIcon(
                              FontAwesomeIcons.user,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        controller: addressController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your address';
                          }
                        },
                        decoration: InputDecoration(
                            label: Text('Enter your address'.toUpperCase()),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade900)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade900)),
                            icon: FaIcon(
                              FontAwesomeIcons.addressCard,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your phone';
                          }
                        },
                        decoration: InputDecoration(
                            label:
                                Text('Enter your phone number'.toUpperCase()),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade900)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade900)),
                            icon: FaIcon(
                              FontAwesomeIcons.phone,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.green.shade900),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AddOrder(
                                name: nameController.text,
                                address: addressController.text,
                                phone: phoneController.text);
                          }
                        },
                        icon: FaIcon(FontAwesomeIcons.forward),
                        label: Text('Place your order'.toUpperCase())),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.01,
                        child: isplaced == true
                            ? LinearProgressIndicator(
                                color: Colors.green.shade900,
                              )
                            : Container(
                                height: 0,
                              ))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  AppBar BuildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text('plantify'.toUpperCase()),
      actions: [
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
            ))
      ],
    );
  }
}
