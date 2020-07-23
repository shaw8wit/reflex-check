import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:game/components/pause.dart';
import 'package:game/components/pauseScreen.dart';
import 'package:game/components/square.dart';
import 'package:game/components/timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences storage = await SharedPreferences.getInstance();
  final Size size = await Flame.util.initialDimensions();
  // await Flame.util.setOrientation(DeviceOrientation.portraitUp);
  final game = MyGame(size, storage);
  runApp(game.widget);
}

class MyGame extends BaseGame with HasWidgetsOverlay, TapDetector {
  final size;
  final storage;
  bool running = true;
  bool started;
  int score, hs;
  math.Random r;
  MyGame(this.size, this.storage) {
    initialize();
    add(Pause());
  }

  void initialize() {
    started = false;
    score = 0;
    hs = storage.getInt('hs') ?? 0;
    r = new math.Random();
    add(Square()
      ..x = size.width / 2
      ..y = size.height / 2);
    add(Timer()
      ..x = size.width / 2
      ..y = 65);
  }

  void save() async {
    components.forEach((e) {
      if (e is Pause) e.paused = !e.paused;
      if (e is Square || e is Timer) markToRemove(e);
    });
    await storage.setInt('hs', hs);
    initialize();
  }

  void addSquare() {
    addLater(Square()
      ..x = r.nextDouble() * (size.width - 80) + 40
      ..y = r.nextDouble() * (size.height - 180) + 140);
  }

  @override
  void onTapUp(details) {
    final touchArea = Rect.fromCenter(
      center: details.localPosition,
      width: 20,
      height: 20,
    );
    bool handled = false;
    components.forEach((e) {
      if (e is Pause && e.rect.overlaps(touchArea)) {
        handled = true;
        e.paused = !e.paused;
        if (running) {
          addWidgetOverlay(
            'PauseMenu',
            PauseScreen(size: size, title: "Game Paused!", status: "Resume"),
          );
          running = false;
          pauseEngine();
        } else {
          removeWidgetOverlay('PauseMenu');
          running = true;
          resumeEngine();
        }
      } else {
        if (e is Square &&
            e.toRect().overlaps(touchArea) &&
            running &&
            !handled) {
          started = true;
          score += 1;
          handled = true;
          hs = score > hs ? score : hs;
          markToRemove(e);
          addSquare();
        } else if (e is Timer && started) {
          e.timeRun = true;
        }
      }
    });
    if (!handled && running) {
      score -= 1;
      addSquare();
    }
  }
}
