import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarWithActions extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String urlImage;
  final Function() function;
  final double scale;
  const CustomAppBarWithActions({
    Key? key,
    required this.title,
    required this.urlImage,
    required this.function,
    required this.scale,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          title,
          style: TextStyle(fontSize: 22, color: Colors.grey[600]),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        radius: 30,
        onTap: () => Get.back(),
        child: Image.asset(
          'assets/images/arrow.png',
          scale: 2.1,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: InkWell(
            onTap: function,
            child: Image.asset(
              urlImage,
              scale: scale,
            ),
          ),
        )
      ],
    );
  }
}
