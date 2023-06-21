import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ParticleFlParticle {
  Color color;
  Color colorEnd;
  BlendMode blendMode;
  late String shapeType;
  double size;
  double startLifespan;
  late double lifespan;
  double startOpacity;
  double endOpacity;
  late double opacity;
  double startScale;
  double endScale;
  late double scale;
  Offset startPosition;
  late Offset position;
  Vector2 startVelocity;
  double maxVelocity;
  late Vector2 velocity;
  Vector2 acceleration;
  double angularVelocity;
  double angle = 0.0;

  double progress = 0;

  late DateTime startTime;

  late DateTime endTime;

  List<String> shapeIdList;

  ParticleFlParticle({
    required this.color,
    this.colorEnd = const Color(0x00000000),
    this.blendMode = BlendMode.srcOver,
    this.shapeIdList = const ['circle'],
    this.size = 10.0,
    this.startLifespan = 1.0,
    this.startOpacity = 1.0,
    this.endOpacity = 0.0,
    this.startScale = 1.0,
    this.endScale = 0.0,
    required this.startPosition,
    required this.startVelocity,
    this.maxVelocity = 100.0,
    required this.acceleration,
    this.angularVelocity = 0.0,
  }) {
    reset();

    startTime = DateTime.now();
    endTime = startTime.add(Duration(seconds: startLifespan.toInt()));
  }

  void reset() {
    shapeType = shapeIdList[math.Random().nextInt(shapeIdList.length)];
    lifespan = startLifespan;
    opacity = startOpacity;
    scale = startScale;
    position = startPosition;
    velocity = startVelocity;
    angle = 0.0;
  }

  bool update(double dt) {
    lifespan -= dt;
    if (lifespan <= 0.0) {
      return true;
    }

    // final DateTime now = DateTime.now();
    // final Duration difference = endTime.difference(startTime);
    // final Duration progressDuration = now.difference(startTime);

    // progress = (progressDuration.inMilliseconds / difference.inMilliseconds)
    //     .clamp(0.0, 1.0);

    //print((progress));

    velocity += acceleration * dt;
    if (velocity.length > maxVelocity) {
      velocity.scale((velocity.length / maxVelocity));
    }
    position += Offset(velocity.x, velocity.y) * dt;

    opacity =
        lerpDouble(endOpacity, startOpacity, (lifespan / startLifespan)) ?? 0.0;
    scale = lerpDouble(endScale, startScale, (lifespan / startLifespan)) ?? 0.0;

    angle += angularVelocity * dt;
    angle %= 2 * math.pi;

    return false;
  }

  Path createStar(double centerX, double centerY, double size) {
    final innerRadius = (size / 2).truncate();
    final outerRadius = (size).truncate();
    final path = Path();

    for (int i = 0; i < 5; i++) {
      final angle = i * math.pi * 2 / 5 - math.pi / 2;
      final dx = centerX + outerRadius * math.cos(angle);
      final dy = centerY + outerRadius * math.sin(angle);
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
      final innerAngle = angle + math.pi * 2 / 10;
      final innerDx = centerX + innerRadius * math.cos(innerAngle);
      final innerDy = centerY + innerRadius * math.sin(innerAngle);
      path.lineTo(innerDx, innerDy);
    }

    path.close();

    path.close();
    return path;
  }

  void render(Canvas canvas) {
    Paint paint = Paint()
      ..color = Color.lerp(colorEnd, color, (lifespan / startLifespan))!
          .withOpacity(opacity)
      ..blendMode = blendMode;

    switch (shapeType) {
      case 'blur_circle':
        var grad = RadialGradient(
          colors: [
            color.withOpacity(1),
            colorEnd.withOpacity(0.6),
            colorEnd.withOpacity(0.35),
            //Colors.transparent,

            // Colors.white.withOpacity(0)
          ],
          //stops: const [
          //   0,
          //   0.3,
          //   1.0
          // ]
        );

        paint = paint
          ..shader = grad.createShader(Rect.fromCircle(
            center: Offset.zero,
            radius: size / 2,
          ));

        canvas.drawCircle(position, size * scale, paint);
        break;
      case 'circle':
        canvas.drawCircle(position, size * scale, paint);
        break;
      case 'outline_circle':
        paint = paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = size / 10;
        canvas.drawCircle(position, size * scale, paint);
        break;
      case 'square':
        Rect rect = Rect.fromLTWH(position.dx - size * scale / 2,
            position.dy - size * scale / 2, size * scale, size * scale);
        canvas.drawRect(rect, paint);
        break;
      case 'triangle':
        Path path = Path();
        double height = math.sqrt(3) / 2 * size * scale;
        path.moveTo(position.dx + size * scale / 2, position.dy + height / 2);
        path.lineTo(position.dx, position.dy - height / 2);
        path.lineTo(position.dx - size * scale / 2, position.dy + height / 2);
        path.close();
        canvas.drawPath(path, paint);
        break;
      case 'star':
        Path path = createStar(position.dx, position.dy, size);
        canvas.drawPath(path, paint);
        break;
    }
  }
}
