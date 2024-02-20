import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:async';

import 'package:mario_v2/Mymario.dart';
import 'package:mario_v2/button.dart';
import 'package:mario_v2/jumpingmario.dart';
import 'package:mario_v2/myshroom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double shroomX = 0.5;

  double shroomY = 1;

  double time = 0;
  double marioSize = 50;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midrun = false;
  bool midjump = false;
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, fontSize: 20));

  void checkIfAteShrooms() {
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY).abs() < 0.05) {
      setState(() {
        // if eaten, move the shroom off the screen
        shroomX = 2;
        marioSize = 100;
      });
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (midjump == false) {
      //this first statement disable the double jump
      midjump = true;
      preJump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          midjump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = "right";
    checkIfAteShrooms();

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkIfAteShrooms();
      if (Mybutton().userisHoldingButton() == true && (marioX + 0.02) < 1) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });

    setState(() {
      marioX += 0.02;
    });
  }

  void moveLeft() {
    direction = "left";
    checkIfAteShrooms();

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkIfAteShrooms();
      if (Mybutton().userisHoldingButton() == true && (marioX - 0.02) > -1) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: Duration(milliseconds: 0),
                    child: midjump
                        ? JumpMario(
                            direction: direction,
                            size: marioSize,
                          )
                        : MyMario(
                            direction: direction,
                            midrun: midrun,
                            size: marioSize,
                          ),
                  ),
                ),
                Container(
                  alignment: Alignment(shroomX, shroomY),
                  child: MyShroom(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 420),
                        child: Container(
                          color: Colors.blue,
                          child: Stack(
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
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 144, 3, 3),
                                  ),
                                  height: 60,
                                  width: 150,
                                  child: Center(
                                    child: Text(
                                      "MENU",
                                      style: GoogleFonts.pressStart2p(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: const Color.fromARGB(
                                            255, 236, 235, 235),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'MARIO',
                            style: gameFont,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '0000',
                            style: gameFont,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'WORLD',
                            style: gameFont,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '1-1',
                            style: gameFont,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'TIME',
                            style: gameFont,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '9999',
                            style: gameFont,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Mybutton(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    function: moveLeft,
                  ),
                  Mybutton(
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                    function: jump,
                  ),
                  Mybutton(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    function: moveRight,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
