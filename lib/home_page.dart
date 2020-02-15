import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Color _color;

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _color = _getRandomColor();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeColor() {
    _controller.forward(from: 0);
    setState(() {
      _color = _getRandomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return GestureDetector(
        onTap: _changeColor,
        child: Scaffold(
          body: AnimatedContainer(
            color: _color,
            child: FadeTransition(
                child: Text(
                  'Hey there',
                  style: GoogleFonts.mcLaren(
                      textStyle: TextStyle(
                          color: _color.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold)),
                ),
                opacity: _animation),
            constraints: const BoxConstraints.expand(),
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
          ),
        ));
  }

  static Color _getRandomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }
}
