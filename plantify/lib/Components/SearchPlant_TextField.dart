import 'package:flutter/material.dart';

class SearchPlant_TextField extends StatefulWidget {
  const SearchPlant_TextField({super.key});

  @override
  State<SearchPlant_TextField> createState() => _SearchPlant_TextFieldState();
}

class _SearchPlant_TextFieldState extends State<SearchPlant_TextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: 'Search Plant',
            border: InputBorder.none),
      ),
    );
  }
}
