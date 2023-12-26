import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/enum/font_type.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:flutter/material.dart';

class BroncoButton extends StatelessWidget {
  final Function onPress;
  final String? text;
  final double? height;
  final double? width;
  final double? rounder;
  final bool hasGradientBg;
  final double? blurRadius;
  final double? textSize;
  final Color? color;
  final FontWeight? fontWeight;
  final bool hasIcon;
  final Widget icon;
  final List<Color>? gradientColors;
  final EdgeInsets? innerPadding;

  const BroncoButton({
    required this.onPress,
    Key? key,
    this.text,
    this.height,
    this.width,
    this.rounder,
    this.hasGradientBg = true,
    this.blurRadius,
    this.textSize,
    this.color,
    this.fontWeight,
    this.hasIcon = false,
    this.icon = const Offstage(),
    this.gradientColors,
    this.innerPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress.call(),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 120.h,
        padding: innerPadding ?? const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color ?? AppTheme.of(context).primaryColor,
                blurRadius: blurRadius ?? 1.0,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: gradientColors ??
                  [
                    color ?? AppTheme.of(context).primaryColor,
                    if (hasGradientBg)
                      AppTheme.of(context).redColor
                    else
                      color ?? AppTheme.of(context).primaryColor,
                  ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(rounder ?? 10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? 'Button',
              style: TextStyle(
                  letterSpacing: 0.5,
                  fontWeight: fontWeight ?? FontWeight.bold,
                  fontFamily: FontFamily.OpenSans,
                  fontSize: textSize ?? 40.sp,
                  color: Colors.white),
            ),
            if (hasIcon) icon,
          ],
        ),
      ),
    );
  }
}
