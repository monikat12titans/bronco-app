import 'package:bronco_trucking/di/app_core.dart';
import 'package:flutter/material.dart';

class EmptyListErrorText extends StatelessWidget {
  const EmptyListErrorText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            PNGPath.sadImage,
            width: 120,
            height: 120,
            color: Colors.black12,
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              StringConstants.errorNoDataFound,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: FontFamily.OpenSans,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
          )
        ],
      ),
    );
  }
}
