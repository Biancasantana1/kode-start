import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_morty/app/infra/infra.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Modular.to.pushNamed(Routes.home);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AppLottie.rick,
              fit: BoxFit.contain,
              repeat: true,
              frameRate: FrameRate.max,
            ),
            const Text(
              'RICK AND MORTY API',
              style: TextStyle(
                color: AppColors.black500,
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
                fontSize: 14.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
