import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:mario_v2/thegame.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/mario_background.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Image(
                  image: AssetImage(
                    'lib/images/Mario_logo.png',
                  ),
                ),
                width: 380,
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 160,
                    height: 70,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => HomePage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF009CDA),
                      ),
                      height: 60,
                      width: 150,
                      child: Center(
                        child: Text(
                          "PLAY",
                          style: GoogleFonts.pressStart2p(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10))
            ],
          ),
        ),
      ),
    );
  }
}
