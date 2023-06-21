import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:particle_fl/particle_fl_particle.dart';
import 'package:particle_fl/particlefl_utils.dart';

final _random = Random();

/// Generates a positive random integer uniformly distributed on the range
/// from [min], inclusive, to [max], exclusive.
int inRange(int min, int max) => min + _random.nextInt(max - min);

abstract class ParticleFLGenerator {
  ParticleFlParticle generateParticle();
  late int maxParticles;
  late int spawnRate;
}

class DreamParticlesGenerator implements ParticleFLGenerator {
  DreamParticlesGenerator() {
    maxParticles = 1000;
    spawnRate = 25;
  }

  @override
  ParticleFlParticle generateParticle() {
    final random = Random();
    double friction = 50;

    // Generate a single particle using ParticleJS config
    return ParticleFlParticle(
      color: Color.fromARGB(255, 251, 85, 8),
      colorEnd: Color.fromARGB(255, 221, 124, 5),
      blendMode: BlendMode.plus,
      shapeIdList: [
        'outline_circle',
        // 'square',
        'circle',
        // 'star'
        // "blur_circle"
      ], //'square',
      size: 60 * random.nextDouble(),
      startLifespan: 5,
      startOpacity: 1,
      endOpacity: 0.2,
      startScale: 1,
      endScale: 0.2,
      startPosition: Offset.zero,
      //speed
      startVelocity: Utils.getRandomVector2() * friction,
      maxVelocity: 2000,
      //gravity
      acceleration:
          Utils.getRandomVector2() * friction, //Vector2(0, 100) * friction
      angularVelocity: Utils.getNonZeroRandomDouble() * pi,
    );
  }

  @override
  late int maxParticles;

  @override
  late int spawnRate;
}

class PixelsParticlesGenerator implements ParticleFLGenerator {
  PixelsParticlesGenerator() {
    maxParticles = 300;
    spawnRate = 60;
  }

  @override
  ParticleFlParticle generateParticle() {
    double friction = 50;
    // Generate a single particle using ParticleJS config
    return ParticleFlParticle(
      color: Color.fromARGB(255, 10, 236, 25),
      colorEnd: Color.fromARGB(255, 54, 13, 215),
      blendMode: BlendMode.plus,
      shapeIdList: [
        'square',
      ], //'square',
      size: 60 * _random.nextDouble(),
      startLifespan: 2,
      startOpacity: 1,
      endOpacity: 0.2,
      startScale: 1,
      endScale: 0.2,
      startPosition: Offset.zero,
      //speed
      startVelocity: Utils.getRandomVector2() * friction,
      maxVelocity: 2000,
      //gravity
      acceleration:
          Utils.getRandomVector2() * friction, //Vector2(0, 100) * friction
      angularVelocity: Utils.getNonZeroRandomDouble() * pi,
    );
  }

  @override
  late int maxParticles;

  @override
  late int spawnRate;
}

class FireParticlesGenerator implements ParticleFLGenerator {
  FireParticlesGenerator() {
    maxParticles = 300;
    spawnRate = 80;
  }

  @override
  ParticleFlParticle generateParticle() {
    double friction = 15;

    // Generate a single particle using ParticleJS config
    return ParticleFlParticle(
      color: Color.fromARGB(255, 250, 6, 6),
      colorEnd: Color.fromARGB(255, 216, 96, 53),
      blendMode: BlendMode.plus,
      shapeIdList: [
        "blur_circle",
        // 'square',
      ],
      size: inRange(40, 60).toDouble(),
      startLifespan: 0.8,
      startOpacity: 1,
      endOpacity: 1,
      startScale: 1,
      endScale: 0.2,
      startPosition: Offset.zero,
      //speed
      startVelocity: Utils.getRandomVector2() * friction,
      maxVelocity: 2000,
      //gravity
      acceleration: Vector2(0, -100) * friction, //Vector2(0, 100) * friction
      angularVelocity: Utils.getNonZeroRandomDouble() * pi, //pi / 4,
    );
  }

  @override
  late int maxParticles;

  @override
  late int spawnRate;
}

class ColorBallParticlesGenerator implements ParticleFLGenerator {
  ColorBallParticlesGenerator() {
    maxParticles = 300;
    spawnRate = 100;
  }

  @override
  ParticleFlParticle generateParticle() {
    double friction = 35;

    // Generate a single particle using ParticleJS config
    return ParticleFlParticle(
      color: Utils.getRandomColor(),
      colorEnd: Utils.getRandomColor(),
      blendMode: BlendMode.lighten,
      shapeIdList: [
        "blur_circle",
        // 'square',
      ],
      size: 65,
      startLifespan: 0.4,
      startOpacity: 1,
      endOpacity: 1,
      startScale: 1,
      endScale: 0.8,
      startPosition: Offset.zero,
      //speed
      startVelocity: Utils.getRandomVector2() * friction,
      maxVelocity: 2000,
      //gravity
      // x(-5..5) y(-5..5)
      acceleration: Vector2(_random.nextInt(10) - 5, _random.nextInt(10) - 5) *
          friction, //Vector2(0, 100) * friction
      angularVelocity: Utils.getNonZeroRandomDouble() * pi, //pi / 4,
    );
  }

  @override
  late int maxParticles;

  @override
  late int spawnRate;
}
