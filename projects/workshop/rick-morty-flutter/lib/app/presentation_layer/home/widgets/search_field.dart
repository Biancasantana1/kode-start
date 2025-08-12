import 'package:flutter/material.dart';
import 'package:rick_morty/app/infra/infra.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.width, 16.height, 20.width, 2.height),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          final hasText = value.text.trim().isNotEmpty;
          return TextField(
            controller: controller,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            cursorColor: AppColors.primary,
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              hintText: 'Search name...',
              hintStyle: const TextStyle(color: AppColors.secondary),
              prefixIcon: const Icon(Icons.search, color: AppColors.secondary),
              suffixIcon: hasText
                  ? Tooltip(
                      message: 'Clear search',
                      child: IconButton(
                        splashRadius: 18,
                        icon: const Icon(Icons.close_rounded,
                            color: AppColors.secondary),
                        onPressed: () {
                          controller.clear();
                          FocusScope.of(context).unfocus();
                          if (onClear != null) {
                            onClear!();
                          } else {
                            onChanged('');
                          }
                        },
                      ),
                    )
                  : null,
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.height,
                horizontal: 16.width,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }
}
