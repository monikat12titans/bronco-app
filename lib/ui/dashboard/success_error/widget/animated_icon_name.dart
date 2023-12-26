import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/dashboard/success_error/success_error_controller.dart';
import 'package:flutter/material.dart';

class AnimatedIconName extends StatefulWidget {
  final SuccessErrorController successErrorController;
  final bool isSuccess;
  final String message;
  final UploadFrom uploadFrom;

  const AnimatedIconName(
      {required this.successErrorController,
      required this.isSuccess,
      required this.message,
      required this.uploadFrom,
      Key? key})
      : super(key: key);

  @override
  _AnimatedIconNameState createState() => _AnimatedIconNameState();
}

class _AnimatedIconNameState extends State<AnimatedIconName>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: widget.successErrorController.animation,
            child: CircleAvatar(
              backgroundColor:
                  widget.isSuccess ? const Color(0xff1f9357) : Colors.redAccent,
              maxRadius: 90,
              child: Icon(
                widget.isSuccess ? Icons.check : Icons.clear,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FadeTransition(
            opacity: widget.successErrorController.animation,
            child: Text(
              widget.isSuccess
                  ? StringConstants.success
                  : StringConstants.error,
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: FontFamily.OpenSans,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FadeTransition(
              opacity: widget.successErrorController.animation,
              child: Text(
                widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 25,
                    fontFamily: FontFamily.OpenSans,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            onTap: () => widget.successErrorController
                .onBackPress(widget.isSuccess, widget.uploadFrom),
            child: Container(
              width: 150,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2.0,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: Center(
                child: Text(
                  StringConstants.btnBack,
                  style: TextStyle(
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.OpenSans,
                      fontSize: 50.sp,
                      color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
