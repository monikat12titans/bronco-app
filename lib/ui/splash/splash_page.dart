import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SvgPicture.asset(
          SVGPath.icon,
          color: AppTheme.of(context).primaryColor,
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
