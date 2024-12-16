import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> rootNavigator = GlobalKey(debugLabel: 'rootNavigator');
NavigatorState getRootNavigator() {
  assert(rootNavigator.currentState != null);
  return rootNavigator.currentState!;
}
