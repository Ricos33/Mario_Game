import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/services.dart';
import 'package:mario_v2/Homescreen.dart';

void main() {
  runApp(Myapp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
