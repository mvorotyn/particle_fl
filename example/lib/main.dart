import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:particle_fl/particle_fl.dart';
import 'package:particle_fl/particle_fl_generators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParticleFL Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ParticleFL Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          BackgroundWithParticles(),
          const Center(
            child: Text(
              'Animated background with ParticleFL',
              style: TextStyle(
                  color: Color.fromARGB(255, 5, 5, 5),
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class ParticlesGame extends FlameGame with HasGameRef<ParticlesGame> {
  ParticlesGame();
  late ParticleFlEmitter emitter;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    emitter = ParticleFlEmitter(generator: FireParticlesGenerator());
    add(emitter);
    // emitter.position = game.size / 2;
  }

  @override
  Color backgroundColor() {
    // Simulate some asynchronous operation
    return Color.fromARGB(
        247, 111, 111, 111); //Color.fromARGB(255, 57, 54, 54);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (emitter.isMounted) {
      emitter.position = game.size / 2;
    }
  }
}

class BackgroundWithParticles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: ParticlesGame());
  }
}
