import 'package:flutter/material.dart';
import 'package:rick_morty/app/infra/infra.dart';

import '../../../domain_layer/domain_layer.dart';
import '../widgets/movie_detail_shimmer.dart';

class MovieDetailPage extends StatefulWidget {
  final HomeCharacterEntity item;

  const MovieDetailPage({super.key, required this.item});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool _loading = true;
  bool _warmupStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _warmupImage();
  }

  Future<void> _warmupImage() async {
    if (_warmupStarted) return;
    _warmupStarted = true;
    try {
      await Future.wait([
        if (widget.item.image.trim().isNotEmpty)
          precacheImage(NetworkImage(widget.item.image), context),
        Future.delayed(const Duration(milliseconds: 400)),
      ]);
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: appBarComponent(
        context,
        isSecondPage: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: _loading
            ? const MovieDetailShimmer()
            : ListView(
                key: const ValueKey('detail-content'),
                padding: EdgeInsets.fromLTRB(
                    20.width, 16.height, 20.width, 24.height),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              item.image,
                              fit: BoxFit.fill,
                              errorBuilder: (_, __, ___) => Container(
                                color: AppColors.black500,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: AppColors.secondary,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            16.width,
                            12.height,
                            14.width,
                            60.height,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name.toUpperCase(),
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14.5,
                                ),
                              ),
                              SizedBox(height: 40.height),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _dotColor(item.status),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.width),
                                  Text(
                                    '${item.status}${item.status.isNotEmpty ? ' - ${item.species}' : ''}',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14.height),
                              Text(
                                'Last known location:',
                                style: TextStyle(
                                  color: AppColors.white.withOpacity(.7),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 2.height),
                              Text(
                                item.locationName.isEmpty
                                    ? '-'
                                    : item.locationName,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 14.height),
                              Text(
                                'First seen in:',
                                style: TextStyle(
                                  color: AppColors.white.withOpacity(.7),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 2.height),
                              Text(
                                item.originName.isEmpty ? '-' : item.originName,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Color _dotColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return AppColors.green;
      case 'dead':
        return AppColors.red;
      default:
        return AppColors.secondary;
    }
  }
}
