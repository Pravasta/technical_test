import 'package:flutter/material.dart';
import 'section/welcome_view.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeView(),
    );
  }
}
