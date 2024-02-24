import 'package:admin_panel/Auth/login.dart';
import 'package:admin_panel/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthStream extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          bool isAuthenticated = snapshot.data != null;

          if (isAuthenticated &&
              _auth.currentUser!.email == 'admin@gmail.com') {
            return MyHomePage();
          } else {
            _auth.signOut();
            return LoginPage();
          }
        }
      },
    );
  }
}
