import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

class FilterSheet extends StatefulWidget {
  final String selectedRegion;
  final String selectedCategory;
  final Function(String region, String category) onApply;

  const FilterSheet({
    super.key,
    required this.selectedRegion,
    required this.selectedCategory,
    required this.onApply,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late String _region;
  late String _category;

  final List<String> _regions = [
    'All Regions',
    'Northern Uganda',
    'Western Uganda',
    'Southwestern Uganda',
    'Eastern Uganda',
    'Central Uganda',
  ];

  final List<String> _categories = [
    'All Categories',
    'National Parks',
    'Waterfalls',
    'Lakes',
    'Mountains',
    'Wildlife',
    'Cultural Sites',
  ];

  @override
  void initState() {
    super.initState();
    _region = widget.selectedRegion;
    _category = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filter Destinations', style: AppTypography.cardHeading),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Regions
          Text('Region', style: AppTypography.actionLabel.copyWith(color: AppColors.jungle)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _regions.map((r) {
              final isSelected = _region == r;
              return ChoiceChip(
                label: Text(r),
                selected: isSelected,
                selectedColor: AppColors.forest,
                backgroundColor: AppColors.ivory,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.charcoal,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isSelected ? AppColors.forest : AppColors.border,
                  ),
                ),
                onSelected: (val) {
                  setState(() => _region = r);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Categories
          Text('Category', style: AppTypography.actionLabel.copyWith(color: AppColors.jungle)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((c) {
              final isSelected = _category == c;
              return ChoiceChip(
                label: Text(c),
                selected: isSelected,
                selectedColor: AppColors.forest,
                backgroundColor: AppColors.ivory,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.charcoal,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isSelected ? AppColors.forest : AppColors.border,
                  ),
                ),
                onSelected: (val) {
                  setState(() => _category = c);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 28),

          // Actions
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'Reset',
                  onPressed: () {
                    setState(() {
                      _region = 'All Regions';
                      _category = 'All Categories';
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  label: 'Apply Filters',
                  onPressed: () {
                    widget.onApply(_region, _category);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
