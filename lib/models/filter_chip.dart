import 'package:flutter/material.dart';

class FilterChipData {
  final String label;
  final Color color;
  final bool isSelected;

  const FilterChipData(
      {@required this.label, @required this.color, this.isSelected = false});
}
