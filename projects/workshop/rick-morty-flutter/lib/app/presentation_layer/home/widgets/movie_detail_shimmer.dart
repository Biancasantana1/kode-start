import 'package:flutter/material.dart';
import 'package:rick_morty/app/infra/infra.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailShimmer extends StatelessWidget {
  const MovieDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final base = AppColors.surface.withOpacity(0.55);
    final highlight = AppColors.surface.withOpacity(0.25);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.width, 16.height, 20.width, 24.height),
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 14 / 9,
                child: Shimmer.fromColors(
                  baseColor: base,
                  highlightColor: highlight,
                  period: const Duration(milliseconds: 1000),
                  child: Container(color: AppColors.secondary),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    16.width, 12.height, 14.width, 60.height),
                child: Shimmer.fromColors(
                  baseColor: base,
                  highlightColor: highlight,
                  period: const Duration(milliseconds: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bar(width: 180.width, height: 20.height),
                      SizedBox(height: 40.height),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.white.withOpacity(.2),
                                width: 1,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.width),
                          _bar(width: 140.width, height: 16.height),
                        ],
                      ),
                      SizedBox(height: 14.height),
                      _bar(width: 150.width, height: 16.height, opacity: .5),
                      SizedBox(height: 6.height),
                      _bar(width: 220.width, height: 16.height),
                      SizedBox(height: 14.height),
                      _bar(width: 120.width, height: 16.height, opacity: .5),
                      SizedBox(height: 6.height),
                      _bar(width: 180.width, height: 16.height),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bar(
      {required double width, required double height, double opacity = 1}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(opacity),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
