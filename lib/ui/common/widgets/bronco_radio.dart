import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:flutter/material.dart';

class BroncoRadio extends StatelessWidget {
  final bool isSelected;

  const BroncoRadio({required this.isSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedColor = AppTheme.of(context).primaryColor;
    return isSelected
        ? Stack(
            children: [
              CustomPaint(
                painter: CircleBorder(selectedColor),
                child: const SizedBox(
                  height: 20,
                  width: 20,
                ),
              ),
              Positioned(
                top: 7,
                bottom: 7,
                left: 7,
                right: 7,
                child: CircleAvatar(
                  maxRadius: 1,
                  backgroundColor: selectedColor,
                ),
              )
            ],
          )
        : CustomPaint(
            painter: CircleBorder(Colors.black12.withOpacity(0.1)),
            child: const SizedBox(
              height: 20,
              width: 20,
            ),
          );
  }
}

class CircleBorder extends CustomPainter {
  final Color ringColor;

  CircleBorder(this.ringColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = ringColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, 7, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
