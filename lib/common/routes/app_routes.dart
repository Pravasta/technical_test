import 'package:flutter/material.dart';

BuildContext get globalContext {
  return AppRoutes.currentContext;
}

class AppRoutes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static get currentContext {
    return navigatorKey.currentState?.context;
  }

  static to(Widget widget) async {
    return await navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static back() {
    if (Navigator.canPop(globalContext) == false) return;
    Navigator.pop(globalContext);
  }

  static toAndRemove(Widget widget) async {
    return await navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }
}
