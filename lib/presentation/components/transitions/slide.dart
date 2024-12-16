import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;

  SlidePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, _) => page,
          transitionsBuilder: (context, animation, _, child) {
            final isRtl = Directionality.of(context) == TextDirection.rtl;
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final begin = isRtl ? Offset(-1.0, 0.0) : Offset(1.0, 0.0);
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
