import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revest/data/database/db.dart';
import 'package:revest/presentation/screens/home/home_screen.dart';
import 'package:revest/provider/db.dart';
import 'package:revest/provider/shared_preferences.dart';
import 'package:revest/utils/extensions/context.dart';
import 'package:revest/utils/theme/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_cached_image/visibility_cached_image.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Future<void> _initializeApp() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      ref.read(sharedPrefsProvider.notifier).state = prefs;
      ref.read(databaseProvider.notifier).state = AppDatabase();
      await VisibilityCacheImageConfig.init(
        loadingType: LoadingType.random,
        maxConcurrentRequests: 6,
      );

      // make sure context is still viable as we are in async function
      if (!mounted) return;
    } finally {
      context.navigator.pushNamedAndRemoveUntil(
        HomeScreen.routeName,
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    _initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AppImages.mainLogo,
        ),
      ),
    );
  }
}
