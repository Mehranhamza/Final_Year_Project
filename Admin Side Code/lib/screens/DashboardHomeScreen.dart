import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Lottie.asset('animation/WelcomeLottie.json'),
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.green),
        ),
      ],
    );
  }
}
