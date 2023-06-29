import 'package:flutter/material.dart';
import 'package:haugiang_app/app/common/widgets/loaders/color_loader_3.dart';

import '../constant.dart';
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
          // color: primaryColor.withOpacity(0.1),
          ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Vui lòng đợi trong giây lát...",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            ColorLoader3(
              radius: 25,
              dotRadius: 7,
            ),
          ],
        ),
      ),
    );
  }
}
