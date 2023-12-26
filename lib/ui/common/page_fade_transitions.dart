import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageFadeTransitions extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Container(
      color: Colors.white,
      child: Align(
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: curve ?? Curves.easeOutCubic,
          ),
          child: child,
        ),
      ),
    );
  }
}
