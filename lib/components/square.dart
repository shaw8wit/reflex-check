import 'dart:math' as math;
import 'dart:ui';
import 'package:game/main.dart';
import 'package:flutter/material.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

class Square extends PositionComponent with HasGameRef<MyGame> {
  static const speed = 0.5;

  @override
  void render(Canvas c) {
    prepareCanvas(c);
    c.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      Paint()..color = Colors.white,
    );
  }

  @override
  void update(double t) {
    super.update(t);
    angle += speed * t;
    angle %= 2 * math.pi;
  }

  @override
  void onMount() {
    width = height = 70;
    anchor = Anchor.center;
  }
}
