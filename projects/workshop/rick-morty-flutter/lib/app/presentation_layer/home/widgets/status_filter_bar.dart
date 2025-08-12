import 'package:flutter/material.dart';
import 'package:rick_morty/app/infra/infra.dart';

class StatusFilterBar extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;

  const StatusFilterBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = <_StatusOption>[
      const _StatusOption(label: 'All', value: ''),
      const _StatusOption(label: 'Alive', value: 'alive'),
      const _StatusOption(label: 'Dead', value: 'dead'),
      const _StatusOption(label: 'Unknown', value: 'unknown'),
    ];

    final String? currentSelected =
        (selected == '' || (selected?.trim().isEmpty ?? false))
            ? ''
            : selected?.trim().toLowerCase();

    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.width, vertical: 8.height),
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.width),
        itemBuilder: (_, i) {
          final opt = options[i];
          final isSelected = opt.value == currentSelected;

          return ChoiceChip(
            label: Text(
              opt.label,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
            selected: isSelected,
            onSelected: (_) => onChanged(opt.value),
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.secondary.withOpacity(0.1),
              ),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        },
      ),
    );
  }
}

class _StatusOption {
  final String label;
  final String? value;
  const _StatusOption({required this.label, required this.value});
}
