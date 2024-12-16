import 'dart:async';
import 'dart:developer' as console;
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revest/app/app.dart';
import 'package:revest/app/app.env.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      await _guardedInitalization();
      FlutterNativeSplash.remove();

      runApp(
        const ProviderScope(
          child: App(),
        ),
      );
    },
    (error, stack) => console.log('[App Crash] $error\n$stack'),
  );
}

Future<void> _guardedInitalization() async {
  // We ensure Flutter binding is initialized here. Otherwise, calls to
  // SystemChrome will not work, for example. This is a no-op if the binding
  // is already initialized.
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  try {
    final envPath = 'assets/.env.${AppFromEnv.appEnv.name}';
    await dotenv.load(fileName: envPath);

    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        console.log('[App Crash Isolateded] $pair');
      }).sendPort,
    );
  } catch (e) {
    console.log(" initializing Error: ${e.toString()}");
  }
}
