import 'package:game/main.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

class Pause extends Component with HasGameRef<MyGame> {
  Rect rect;
  bool paused = false;
  @override
  void render(Canvas c) {
    if (paused) {
      c.drawRect(rect, Paint()..color = Colors.green);
    } else {
      c.drawRect(rect, Paint()..color = Colors.red);
    }
  }

  @override
  void update(double t) {}

  @override
  void onMount() {
    rect = Rect.fromLTWH(gameRef.size.width * 0.85, 35, 60, 60);
  }
}
