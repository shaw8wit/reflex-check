import 'package:game/components/pauseScreen.dart';
import 'package:game/main.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

class Timer extends PositionComponent with HasGameRef<MyGame> {
  Rect rect;
  bool timeRun;
  double value;
  Offset offset, offset2;
  TextPainter tp, tp2;
  TextStyle textStyle;

  @override
  void render(Canvas c) {
    prepareCanvas(c);
    c.drawRect(
      rect,
      Paint()..color = Color(0xffffffff),
    );
    c.drawCircle(offset2, 32, Paint()..color = Color(0xffffffff));
    tp.paint(c, offset);
    tp2.paint(c, offset2 - Offset(31, 24));
  }

  @override
  void update(double t) {
    if (value > 0 && timeRun) {
      value -= t;
    } else {
      if (timeRun) {
        gameRef.save();
        gameRef.running = false;
        gameRef.addWidgetOverlay(
          'PauseMenu',
          PauseScreen(
            size: gameRef.size,
            title: "Game Over!",
            status: "Re-start",
          ),
        );
        gameRef.pauseEngine();
      }
    }
    tp.text = TextSpan(
      text: "${gameRef.score} ${value.toInt()}",
      style: textStyle,
    );
    tp2.text = TextSpan(
      text: "${gameRef.hs}",
      style: textStyle,
    );
    tp.layout(minWidth: 120, maxWidth: 120);
    tp2.layout(minWidth: 60, maxWidth: 60);
    super.update(t);
  }

  @override
  void onMount() {
    width = 120;
    height = 60;
    value = 20;
    timeRun = false;
    offset = Offset(0, 7);
    offset2 = Offset(-x * 0.55, y * 0.48);
    tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp2 = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(color: Color(0xff000000), fontSize: 38);
    rect = Rect.fromLTWH(0, 0, width, height);
    anchor = Anchor.center;
  }
}
