import 'package:flutter/material.dart';

import '../../core/utils/theme.dart';

class CircularProgress extends StatelessWidget {
  final Color? color;
  final double? size;
  final double? strokeWidth;
  final double? value;
  const CircularProgress({
    super.key,
    this.color,
    this.strokeWidth,
    this.size,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 20,
        height: size ?? 20,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: strokeWidth ?? 4.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? CustomTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
