import 'package:dashboard/views/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({final Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SplashController {

  @override
  void initState() {
    initApp();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Container();
}
