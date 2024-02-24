import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plantify/Components/Product_Tile.dart';
import 'package:plantify/Components/SearchPlant_TextField.dart';

class HomeScreen_Body extends StatefulWidget {
  const HomeScreen_Body({super.key});

  @override
  State<HomeScreen_Body> createState() => _HomeScreen_BodyState();
}

class _HomeScreen_BodyState extends State<HomeScreen_Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: double.infinity,
          child: Lottie.asset('assets/animation/Welcome.json'),
        ),
        SearchPlant_TextField(),
        Expanded(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 60,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(),
                  // color: Color(0xFFC9E4CA).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              ProductTile(),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Lottie.asset(
                  'assets/animation/Footer.json',
                )),
            Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Lottie.asset(
                  'assets/animation/Footer.json',
                ))
          ],
        )
      ],
    );
  }
}
