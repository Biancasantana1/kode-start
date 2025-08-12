import 'package:flutter/material.dart';
import 'package:rick_morty/app/infra/infra.dart';
import 'package:shimmer/shimmer.dart';

class CharacterShimmerList extends StatelessWidget {
  final int itemCount;
  const CharacterShimmerList({super.key, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    final base = AppColors.surface.withOpacity(0.55);
    final highlight = AppColors.surface.withOpacity(0.25);

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: itemCount + 1,
      itemBuilder: (context, index) {
        if (index == itemCount) return SizedBox(height: 24.height);
        return Container(
          margin: EdgeInsets.fromLTRB(20.width, 14.height, 20.width, 0.height),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Shimmer.fromColors(
            baseColor: base,
            highlightColor: highlight,
            period: const Duration(milliseconds: 1000),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 21 / 9,
                  child: Container(color: AppColors.secondary),
                ),
                Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
