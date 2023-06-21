<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->


## Features

ParticleFL offers a simple method for the Flutter Flame library to display particle systems. 
This makes it very simple to add special effects like fire, smoke, snow, explosions, and so on.

<!-- ## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package. -->

## Usage

See animated background widget in
 `/example` folder.


Use inside FlameGame:
```dart
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
```

## Additional information

You can choose another generator or write your own;
