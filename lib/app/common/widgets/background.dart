import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -80,
            child: Image.asset("assets/images/background-large.png"),
          ),
          Positioned(
            bottom: -50,
            left: -80,
            child: Image.asset("assets/images/background-large.png"),
          ),
          Positioned(
            top: 200,
            left: -40,
            child: Image.asset("assets/images/background-small.png"),
          ),
          Positioned(
            bottom: 200,
            right: -40,
            child: Image.asset("assets/images/background-small.png"),
          ),
        ],
      ),
    );
  }
}
