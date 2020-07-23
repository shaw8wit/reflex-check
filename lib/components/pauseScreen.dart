import 'dart:ui';

import 'package:flutter/material.dart';

class PauseScreen extends StatelessWidget {
  const PauseScreen({
    Key key,
    @required this.size,
    @required this.title,
    @required this.status,
  }) : super(key: key);

  final Size size;
  final String title, status;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size.width / 2,
        height: size.width / 2,
        decoration: BoxDecoration(
          color: const Color(0xff000000),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffffffff),
              blurRadius: 8.0,
              spreadRadius: 2,
            )
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(title),
              Text("Press the green\n\nbutton to $status"),
            ],
          ),
        ),
      ),
    );
  }
}
