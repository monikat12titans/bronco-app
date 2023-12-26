import 'package:flutter/material.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:shimmer/shimmer.dart';

///
/// This class provides shimmer widget when data is being fetched from server
///
class ShimmerWidget extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double width;
  final double height;
  final double borderRadius;
  final Widget child;

  const ShimmerWidget(
      {this.padding,
      this.margin,
      this.width = 150,
      this.height = 180,
      this.borderRadius = 10,
      this.child = const Offstage()});

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return ShimmerWrapper(Container(
        padding: padding,
        margin: margin,
        width: width,
        height: height,
        decoration:
            BoxDecoration(color: _appTheme.shimmerBackgroundColor, borderRadius: BorderRadius.circular(borderRadius)),
        child: child));
  }
}

class ShimmerWrapper extends StatelessWidget {
  final Widget child;

  const ShimmerWrapper(this.child);

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return Shimmer.fromColors(
      baseColor: _appTheme.shimmerBaseColor,
      highlightColor: _appTheme.shimmerHighlightColor,
      child: child,
    );
  }
}
