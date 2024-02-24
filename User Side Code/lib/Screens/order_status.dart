import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:plantify/Screens/Auth/login.dart';
import 'package:plantify/Screens/HomeScreen.dart';

class order_status extends StatefulWidget {
  final String? PlantID;
  final String? PlantName;
  final int? TotalQuantity;
  final int? TotalPrice;
  final int? orderID;
  order_status(
      {super.key,
      required this.PlantID,
      required this.orderID,
      required this.PlantName,
      required this.TotalPrice,
      required this.TotalQuantity});

  @override
  State<order_status> createState() => _order_statusState();
}

class _order_statusState extends State<order_status> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(),
      body: Column(
        children: [
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
                      Text('${widget.orderID}'),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(child: Lottie.asset('assets/animation/OrderPending.json')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Order Status:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    color: Colors.red.shade900,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'Pending',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.green.shade900),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomeScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
              icon: FaIcon(FontAwesomeIcons.house),
              label: Text('Go to Home Page'))
        ],
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
