import 'dart:math';
import 'package:flutter/material.dart';
import 'my_painter_canvas.dart';
import 'particle.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({Key? key}) : super(key: key);
  @override
  _MyPainterState createState() => _MyPainterState();
}

Color getRandomColor(Random rng) {
  var a = rng.nextInt(256);
  var r = rng.nextInt(256);
  var g = rng.nextInt(256);
  var b = rng.nextInt(256);
  return Color.fromARGB(a, r, g, b);
}

double maxRadius = 6;
double maxSpeed = 0.2;
double maxTheta = 2.0 * pi;

class _MyPainterState extends State<MyPainter> with TickerProviderStateMixin {
  List<Particle> particles = [];
  late Animation<double> animation;
  late AnimationController controller;
  Random rgn = Random(100);
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          //
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();

    //init particles
    particles = List<Particle>.generate(100, (index) {
      var element = Particle();
      element.color = getRandomColor(rgn);
      element.position = const Offset(-1, -1);
      element.speed = rgn.nextDouble() * maxSpeed;
      element.theta = rgn.nextDouble() * maxTheta;
      element.radious = rgn.nextDouble() * maxRadius;
      return element;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: CustomPaint(
      painter: MyPainterCanvas(rgn, particles, animation.value),
      child: Container(color: Colors.white30),
    ));
  }
  // _MyPainterState(this.particles)
}
