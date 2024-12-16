import 'package:flutter/material.dart';
import 'package:revest/presentation/components/transitions/slide.dart';
import 'package:revest/presentation/screens/home/home_screen.dart';
import 'package:revest/presentation/screens/product/details/product_details.dart';
import 'package:revest/presentation/screens/splash/splash_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
            const HomeScreen(),
        settings: settings,
      );

    case ProductDetails.routeName:
      return SlidePageRoute(
        page: ProductDetails(
          productId: settings.arguments as int,
        ),
      );

    default:
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
            const SplashScreen(),
        settings: settings,
      );
  }
}
