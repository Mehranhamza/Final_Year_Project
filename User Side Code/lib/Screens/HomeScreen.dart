import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantify/Components/HomeScreen_Body.dart';
import 'package:plantify/Screens/Auth/login.dart';
import 'package:plantify/Screens/User_Cart.dart';
import 'package:plantify/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: BuildAppBar(),
            backgroundColor: BackgroundColor,
            body: HomeScreen_Body()));
  }

  AppBar BuildAppBar() {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text('plantify'.toUpperCase()),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
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
    );
  }
}
