import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart' as cri;

class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return cri.CustomRefreshIndicator(
      onRefresh: onRefresh,
      offsetToArmed: 80.0,
      builder: (BuildContext context, Widget child, cri.IndicatorController controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final double pullValue = controller.value.clamp(0.0, 1.5);
            final double containerHeight = 80.h * pullValue;

            return Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0.0, containerHeight),
                  child: child,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 80.h * (controller.isLoading ? 1.0 : pullValue),
                    child: Center(
                      child: SizedBox(
                        width: 80.r,
                        height: 80.r,
                        child: Lottie.asset(
                          'assets/lottie/coin circling wallet.json',
                          fit: BoxFit.contain,
                          animate: controller.isLoading || controller.value > 0.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: child,
    );
  }
}
