import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantify/Screens/AR_splash_screen.dart';
import 'package:plantify/Screens/Auth/Signup.dart';
import 'package:plantify/Screens/Auth/auth_stream.dart';
import 'package:plantify/Screens/Auth/login.dart';
import 'package:plantify/Screens/HomeScreen.dart';
import 'package:plantify/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plantify',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                  color: Colors.black,
                  fontSize: 25)),
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
                  .apply(
            displayColor: Colors.black,
            bodyColor: Colors.black,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade900),
          useMaterial3: true,
        ),
        home: AuthStream());
  }
}

class AppPermission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection("AppPermission").snapshots(),
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          var data = snapshots.data!.docs;
          if (data.isNotEmpty) {
            DocumentSnapshot doc = data.first;
            var docid = doc.id;
            var appPermission = doc['App_Permission'];

            return appPermission == true
                ? AuthStream()
                : Scaffold(
                    body: Center(child: Text('App is locked by 1066')),
                  );
          } else {
            return Text('No Data');
          }
        } else {
          return Text('No Data');
        }
      },
    );
  }
}
