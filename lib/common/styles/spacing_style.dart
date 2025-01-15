import 'package:Saz/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TSpacingStyle{
  static const EdgeInsetsGeometry paddingWithAppBarHeigth = EdgeInsets.only(
    top: TSizes.appBarHeight,
              left: TSizes.defaultSpace,
              right: TSizes.defaultSpace,
              bottom: TSizes.defaultSpace
  );
}