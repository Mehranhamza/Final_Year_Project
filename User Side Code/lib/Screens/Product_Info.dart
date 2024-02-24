import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plantify/Screens/AR_splash_screen.dart';
import 'package:plantify/Screens/order_info.dart';

class Product_Info extends StatefulWidget {
  int? index;
  String? PlantImage;
  String? PlantName;
  String? PlantID;
  int? PlantPrice;
  String? PlantDesc;
  String? ModelURL;
  Product_Info(
      {super.key,
      required this.index,
      required this.PlantName,
      required this.PlantImage,
      required this.PlantPrice,
      required this.PlantDesc,
      required this.ModelURL,
      required this.PlantID});

  @override
  State<Product_Info> createState() => _Product_InfoState();
}

class _Product_InfoState extends State<Product_Info> {
  int? quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BuildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
                  child: Hero(
                      tag: 'Plant_Image_${widget.index}',
                      child: Image.network(
                        '${widget.PlantImage}',
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
                      )),
                ),
              ),
              Row(
                children: [
                  Text(
                    '${widget.PlantName}'.toUpperCase(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Text(
                          '${widget.PlantDesc}',
                          style: TextStyle(height: 2, wordSpacing: 2),
                        )),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Price:'.toUpperCase(),
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              '${widget.PlantPrice}-pkr'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red.shade900),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          AR(
                                        modelURL: widget.ModelURL,
                                      ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(-1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        var offsetAnimation =
                                            animation.drive(tween);

                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'AR',
                                  style: TextStyle(fontSize: 25),
                                )),
                            Positioned(
                                top: 0,
                                bottom: 40,
                                child: Lottie.asset(
                                  'assets/animation/AR.json',
                                  height:
                                      MediaQuery.of(context).size.height * 0.21,
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,
                                ))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green.shade900),
                        child: IconButton(
                          onPressed: () {
                            if (quantity! > 0) {
                              setState(() {
                                quantity = quantity! - 1;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Center(
                            child: Text(
                          '$quantity',
                          style: TextStyle(fontSize: 30),
                        )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green.shade900),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              quantity = quantity! + 1;
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green.shade900),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Payment method'.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                actions: [
                                  Center(
                                    child: Column(
                                      children: [
                                        ElevatedButton.icon(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green.shade900),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                            ),
                                            onPressed: () {
                                              int? totalprice =
                                                  widget.PlantPrice! *
                                                      quantity!;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          order_info(
                                                            PlantID:
                                                                widget.PlantID,
                                                            PlantName: widget
                                                                .PlantName,
                                                            TotalPrice:
                                                                totalprice,
                                                            TotalQuantity:
                                                                quantity,
                                                          ))));
                                            },
                                            icon: Icon(Icons.delivery_dining),
                                            label: Text('Cash on delievery'
                                                .toUpperCase())),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        ElevatedButton.icon(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green.shade900),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                            ),
                                            onPressed: () {},
                                            icon: Icon(Icons.payment),
                                            label: Text(
                                                'Online Payment'.toUpperCase()))
                                      ],
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.shopping_bag),
                      label: Text('Process to pay'.toUpperCase()))
                ],
              )
            ]),
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
            onPressed: () {},
            icon: Icon(
              Icons.logout,
              color: Colors.black,
              size: 30,
            ))
      ],
    );
  }
}
