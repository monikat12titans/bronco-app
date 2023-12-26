import 'package:bronco_trucking/di/app_core.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final Function onPress;
  final double? width;
  final double? height;
  final String? text;
  final double? rounderCorner;
  final double? blurRadius;

  const CancelButton(
      {required this.onPress,
      Key? key,
      this.width,
      this.height,
      this.text,
      this.rounderCorner,
      this.blurRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      onTap: () => onPress.call(),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 120.h,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: blurRadius ?? 6.0,
              ),
            ],
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(rounderCorner ?? 10))),
        child: Center(
          child: Text(
            text ?? StringConstants.btnCancel,
            style: TextStyle(
                letterSpacing: 0.5,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.OpenSans,
                fontSize: 40.sp,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
