import 'package:bronco_trucking/di/app_core.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String? errorMessage;

  const ErrorText({Key? key, this.errorMessage}) : super(key: key);

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
          const Text(
            StringConstants.oh,
            style: TextStyle(
                fontSize: 30,
                fontFamily: FontFamily.OpenSans,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              errorMessage ?? StringConstants.errorSomethingWentWrong2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: FontFamily.OpenSans,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }
}
