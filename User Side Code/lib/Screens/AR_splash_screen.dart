import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class AR extends StatefulWidget {
  final String? modelURL;
  const AR({Key? key, required this.modelURL}) : super(key: key);

  @override
  State<AR> createState() => _ARState();
}

class _ARState extends State<AR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModelViewer(
        backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        src: widget.modelURL ?? '',
        alt: 'A 3D model of an astronaut',
        ar: true,
        autoRotate: true,
        iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
        disableZoom: true,
      ),
    );
  }
}
