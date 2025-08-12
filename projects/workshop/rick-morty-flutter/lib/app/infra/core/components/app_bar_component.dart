import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_morty/app/infra/infra.dart';

PreferredSizeWidget appBarComponent(
  BuildContext context, {
  bool isSecondPage = false,
  VoidCallback? onMenuTap,
  VoidCallback? onProfileTap,
}) {
  const double toolbarHeight = kToolbarHeight * 2.3;

  return AppBar(
    backgroundColor: AppColors.background,
    elevation: 0,
    toolbarHeight: toolbarHeight,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    leading: Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (isSecondPage) {
            Navigator.of(context).maybePop();
            return;
          }
          if (onMenuTap != null) onMenuTap();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14.width, top: 18.height),
          child: isSecondPage
              ? const Icon(Icons.arrow_back, color: AppColors.secondary)
              : SvgPicture.asset(AppIcons.menu, height: 21, width: 21),
        ),
      ),
    ),
    actions: [
      Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onProfileTap,
          child: Padding(
            padding: EdgeInsets.only(right: 14.width, top: 12.height),
            child: SvgPicture.asset(AppIcons.profile, height: 31, width: 31),
          ),
        ),
      ),
    ],
    flexibleSpace: SafeArea(
      top: true,
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 4.height),
            child: Image.asset(
              AppImages.logo,
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            'RICK AND MORTY API',
            style: TextStyle(
              color: AppColors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
              fontSize: 14.5,
            ),
          ),
          SizedBox(height: 23.height),
        ],
      ),
    ),
  );
}
