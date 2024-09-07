import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tracker_app/View/world_state.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
      vsync: this)..repeat();

  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), () => {
      Navigator.push(context, MaterialPageRoute(builder: (context) => worldState()))
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child: Center(
                  child: Image(image: AssetImage('image/virusss.png')),
                ),
              ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
                }
              ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          
          Align(
            alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Corona Virus", textAlign: TextAlign.center, style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("Tracker App", textAlign: TextAlign.center, style: TextStyle(fontSize: 34, color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              )),
        ],
      ),
    );
  }
}
