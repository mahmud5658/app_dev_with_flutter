import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/asset_paths.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.logoSize});

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetPaths.logo,
      width: logoSize,
    );
  }
}
