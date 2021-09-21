// import 'package:cv_page/my_painter.dart';
import 'package:flutter/material.dart';
import 'particle.dart';
import 'dart:math';

Offset polarToCartesian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class MyPainterCanvas extends CustomPainter {
  List<Particle> particles;
  Random rgn;
  double animValue;
  MyPainterCanvas(this.rgn, this.particles, this.animValue);
  @override
  void paint(Canvas canvas, Size size) {
    // update the objects
    for (var p in particles) {
      var velocity = polarToCartesian(p.speed, p.theta);
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;
      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = rgn.nextDouble() * size.width;
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        dy = rgn.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    }
    for (var p in particles) {
      var paint = Paint();
      paint.color = p.color;
      canvas.drawCircle(p.position, p.radious, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
