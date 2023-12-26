import 'package:bronco_trucking/di/app_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_theme.dart';

class CustomProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppThemeState _appTheme = AppTheme.of(context);
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(100.h))),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              top: 3,
              bottom: 3,
              left: 3,
              right: 3,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor:
                    AlwaysStoppedAnimation<Color>(_appTheme.primaryColor),
              ),
            ),
            Positioned(
                top: 15,
                bottom: 15,
                left: 15,
                right: 15,
                child: SvgPicture.asset(
                  SVGPath.icon,
                  color: AppTheme.of(context).primaryColor,
                ))
          ],
        ),
      ),
    );
  }
}
