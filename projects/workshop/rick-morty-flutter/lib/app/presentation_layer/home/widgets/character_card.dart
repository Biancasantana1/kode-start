import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rick_morty/app/domain_layer/domain_layer.dart';
import 'package:rick_morty/app/infra/infra.dart';

class CharacterCard extends StatelessWidget {
  final HomeCharacterEntity item;

  const CharacterCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed(
        Routes.movieDetail,
        arguments: item,
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(20.width, 14.height, 20.width, 0.height),
        decoration: BoxDecoration(
          color: AppColors.black200,
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                item.image,
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.black200,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.height),
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.secondary,
                      size: 40,
                    ),
                  ),
                ),
                loadingBuilder: (ctx, child, prog) {
                  if (prog == null) return child;
                  return Container(
                    color: AppColors.black200,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(
                    horizontal: 14.width, vertical: 10.height),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  item.name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
