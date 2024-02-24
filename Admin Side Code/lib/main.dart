import 'package:admin_panel/Auth/auth_stream.dart';
import 'package:admin_panel/firebase_options.dart';
import 'package:admin_panel/screens/AppPermission.dart';
import 'package:admin_panel/screens/DashboardHomeScreen.dart';
import 'package:admin_panel/screens/OrderScreen.dart';
import 'package:admin_panel/screens/plant/add_plant.dart';
import 'package:admin_panel/screens/plant/manage_plant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the AllEmails of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade900),
        useMaterial3: true,
      ),
      home: AuthStream(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget currentScreen = DashboardHome();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AuthStream(),
                  ));
                },
                icon: Icon(Icons.logout_outlined))
          ],
          centerTitle: true,
          title: Text(
            'Admin Panel'.toUpperCase(),
            style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
          ),
        ),
        body: ResponsiveBuilder(builder: (context, sizingInformation) {
          bool isDesktop =
              sizingInformation.deviceScreenType == DeviceScreenType.desktop;

          return isDesktop
              ? Row(children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.12,
                    decoration: BoxDecoration(),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  updateScreen(DashboardHome());
                                },
                                icon: Container(
                                  margin: EdgeInsets.only(right: 40),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'icons/homepage.png',
                                          height: 60,
                                          width: 60,
                                        ),
                                        Text(
                                          'Home page'.toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            ExpansionTile(
                              title: Image.asset(
                                'icons/plant.png',
                                scale: 1,
                              ),
                              children: [
                                Container(
                                  color: Colors.green,
                                  width: double.infinity,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {
                                        updateScreen(add_plant());
                                      },
                                      child: Text(
                                        'Add plant'.toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: Colors.green,
                                  width: double.infinity,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {
                                        updateScreen(manage_plant());
                                      },
                                      child: Text(
                                        'Manage plant'.toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  updateScreen(AllEmails());
                                },
                                icon: Container(
                                  margin: EdgeInsets.only(right: 40),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'icons/delivery.png',
                                        height: 70,
                                        width: 70,
                                      ),
                                      Text(
                                        'Orders'.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),
                            IconButton(
                                onPressed: () {
                                  updateScreen(App_Permission());
                                },
                                icon: Container(
                                  margin: EdgeInsets.only(right: 40),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'icons/homepage.png',
                                          height: 60,
                                          width: 60,
                                        ),
                                        Text(
                                          'App Permission'.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: currentScreen,
                  ))
                ])
              : Container(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                updateScreen(DashboardHome());
                              },
                              icon: Container(
                                margin: EdgeInsets.only(right: 40),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'icons/homepage.png',
                                        height: 60,
                                        width: 60,
                                      ),
                                      Text(
                                        'Home page'.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          ExpansionTile(
                            title: Image.asset(
                              'icons/plant.png',
                              height: 80,
                              width: 80,
                            ),
                            children: [
                              Container(
                                color: Colors.green,
                                width: double.infinity,
                                child: TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () {},
                                    child: Text(
                                      'Add plant'.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: Colors.green,
                                width: double.infinity,
                                child: TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () {},
                                    child: Text(
                                      'Manage plant'.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                updateScreen(AllEmails());
                              },
                              icon: Container(
                                margin: EdgeInsets.only(right: 40),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'icons/delivery.png',
                                      height: 70,
                                      width: 70,
                                    ),
                                    Text(
                                      'Orders'.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                );
        }));
  }

  void updateScreen(Widget NewScreen) {
    setState(() {
      currentScreen = NewScreen;
    });
  }
}
