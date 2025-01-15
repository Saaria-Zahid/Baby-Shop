import 'package:Saz/utils/constants/colors.dart';
import 'package:flutter/material.dart';


class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.child,
    this.padding = 0,
    this.bgColor = TColors.white,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
  });

  final double? width;
  final double? height;
  final double? radius;
  final double? padding;
  final Widget? child;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: bgColor,
      ),
      child: child,
    );
  }
}