library particle_fl;

import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';

import 'package:flutter/material.dart';
import 'package:particle_fl/particle_fl_generators.dart';
import 'package:particle_fl/particle_fl_particle.dart';

class ParticleFlEmitter extends PositionComponent {
  ParticleFlEmitter({required this.generator});
  late ParticleFLGenerator generator;
  late List<ParticleFlParticle> active_particles = [];

  @override
  Future<void> onLoad() async {
    spawnParticles();
    print('emitter started');
  }

  Future<void> spawnParticles() async {
    while (true) {
      // particleGenerator();
      var particle = generator.generateParticle();

      // Add generated particle to the particles list
      active_particles.addAll([particle]);

      // Optional: Limit the number of active_particles in the list to avoid memory issues
      if (active_particles.length > generator.maxParticles) {
        active_particles.removeRange(
            0, active_particles.length - generator.maxParticles);
        //print('22222 rrrrrr ${active_particles.length}');
      }

      await Future.delayed(Duration(milliseconds: 1000 ~/ generator.spawnRate));
    }
  }

  @override
  void render(Canvas canvas) {
    // super.render(canvas);

    for (var element in active_particles) {
      element.render(canvas);
    }
  }

  @override
  void update(double dt) {
    // super.update(dt);

    var toRemove2 = [];
    for (var element in active_particles) {
      if (element.lifespan <= 0.0) {
        // print('removed');
        toRemove2.add(element);
      }
      element.update(dt);
    }
    active_particles.removeWhere((e) => toRemove2.contains(e));
  }
}
