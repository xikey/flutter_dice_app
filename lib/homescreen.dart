import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  AnimationController _controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    animation.addListener(() {
      setState(() {});
      // print(_controller.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDiceNumber = Random().nextInt(6) + 1;
          rightDiceNumber = Random().nextInt(6) + 1;
        });
        // print('Completed');
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text('Zikey Dicer', style: GoogleFonts.orbitron(
            textStyle:
            TextStyle(fontSize: 20, color: Colors.black)),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage(
                            'assets/images/dice-png-$leftDiceNumber.png'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage(
                            'assets/images/dice-png-$rightDiceNumber.png'),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 200,
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: TextButton(
                onPressed: () {
                  roll();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.white70;
                      return Colors.white; // Defer to the widget's default.
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ))

                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),

//
                child: Text(
                  'Roll',
                  style: GoogleFonts.orbitron(
                      textStyle:
                          TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
