import 'dart:async';

import 'package:covid_tracker_app/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{
  @override
 late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5),
        () => Navigator.push(context, MaterialPageRoute(builder: (context)=>
        WorldStatesScreen()))
    );

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           AnimatedBuilder(
               animation: _controller,
               child: Container(
                 width: 200,
                 height: 200,
                 child: const Center(
                   child: Image(image: AssetImage('images/coronavirus.png')),
                 ),
               ),
               builder: (BuildContext,Widget? child){
                 return Transform.rotate(
                     angle: _controller.value*2.0*math.pi,
                 child: child,
                 );
               }),
            SizedBox(height: MediaQuery.of(context).size.height*.08,),
            Align(
              alignment: Alignment.center,
              child: Text('Covid_19\nTracker App',textAlign: TextAlign.center,style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 25
              ),),
            )
          ],
        ),
      ),
    );
  }
}

