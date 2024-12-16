import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revest/app/app.dart';
import 'package:revest/presentation/screens/home/home_screen.dart';
import 'package:revest/presentation/screens/product/details/product_details.dart';
import 'package:revest/presentation/screens/product/product_widget.dart';
import 'package:revest/presentation/screens/product/widgets/carousel_widget.dart';
import 'package:revest/presentation/screens/product/widgets/image_widget.dart';
import 'package:revest/presentation/screens/splash/splash_screen.dart';

void main() {
  group('UI Tests for the App', () {
    testWidgets('SplashScreen shows logo and navigates to HomeScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SplashScreen()));

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('HomeScreen displays list of products and can navigate to ProductDetails', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      await tester.pumpAndSettle();

      expect(find.byType(ProductWidget), findsWidgets);

      await tester.tap(find.byType(ProductWidget).first);
      await tester.pumpAndSettle();

      expect(find.byType(ProductDetails), findsOneWidget);
    });

    testWidgets('ProductDetails displays carousel and images correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: ProductDetails(
        productId: 2,
      )));

      await tester.pumpAndSettle();

      expect(find.byType(CarouselWithDots), findsOneWidget);

      expect(find.byType(ImageWidget), findsWidgets);
    });

    testWidgets('Tapping product on HomeScreen navigates to ProductDetails', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      await tester.pumpAndSettle();

      await tester.tap(find.byType(ProductWidget).first);
      await tester.pumpAndSettle();

      expect(find.byType(ProductDetails), findsOneWidget);
    });

    testWidgets('Change Locale and verify localization updates', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(),
        locale: const Locale('ar'),
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: [],
      ));

      await tester.pumpAndSettle();

      expect(find.text('الرئيسية'), findsOneWidget);
    });

    testWidgets('HomeScreen scrolls properly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      await tester.pumpAndSettle();

      expect(find.byType(Scrollable), findsOneWidget);

      await tester.drag(find.byType(Scrollable), const Offset(0, -200));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Scrollable), const Offset(0, 200));
      await tester.pumpAndSettle();
    });

    testWidgets('Full App Flow Test', (WidgetTester tester) async {
      await tester.pumpWidget(App());

      expect(find.byType(SplashScreen), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(HomeScreen), findsOneWidget);

      await tester.tap(find.byType(ProductWidget).first);
      await tester.pumpAndSettle();

      expect(find.byType(ProductDetails), findsOneWidget);
    });

    testWidgets('Check if the app saves the theme change (dark/light mode)', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      await tester.pumpAndSettle();

      expect(Theme.of(tester.element(find.byType(HomeScreen))).brightness, Brightness.light);

      await tester.tap(find.byIcon(Icons.brightness_6));
      await tester.pumpAndSettle();

      expect(Theme.of(tester.element(find.byType(HomeScreen))).brightness, Brightness.dark);
    });
  });
}
