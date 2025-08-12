import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_morty/app/infra/infra.dart';

class ErrorViewComponent extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;

  const ErrorViewComponent({
    super.key,
    this.title = 'Oops! Something went wrong.',
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.black200,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24,
                      color: AppColors.primary.withOpacity(.15),
                    ),
                  ],
                ),
                child: Center(
                  child: Lottie.asset(
                    AppLottie.morty,
                    fit: BoxFit.contain,
                    repeat: true,
                    frameRate: FrameRate.max,
                  ),
                ),
              ),
              SizedBox(height: 14.height),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.height),
              Text(
                message,
                style: TextStyle(
                  color: Colors.white.withOpacity(.75),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.height),
              SizedBox(
                width: 180,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try again'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
