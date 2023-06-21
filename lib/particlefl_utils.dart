import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

class Utils {
  static Vector2 randomVector2() {
    final rng = Random();
    return Vector2(rng.nextDouble(), rng.nextDouble());
  }

  static Color getRandomColor() {
    final r = Random().nextInt(256);
    final g = Random().nextInt(256);
    final b = Random().nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }

  static double getRandomDouble({double min = 0, required double max}) {
    final random = Random();
    return min + random.nextDouble() * (max - min);
  }

  static double getNonZeroRandomDouble() {
    final random = Random();
    return random.nextDouble() * 2 * (random.nextBool() ? 1 : -1);
  }

  static Vector2 getRandomVector2() {
    return Vector2(getNonZeroRandomDouble(), getNonZeroRandomDouble());
  }
}
