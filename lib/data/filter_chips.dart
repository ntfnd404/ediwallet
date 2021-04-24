import 'package:ediwallet/models/filter_chip.dart';
import 'package:flutter/material.dart';

List<FilterChipData> filterChips() {
  return <FilterChipData>[
    const FilterChipData(
      label: 'Price: Low To High',
      color: Colors.green,
    ),
    const FilterChipData(
      label: 'Price: High To Low',
      color: Colors.red,
    ),
    const FilterChipData(
      label: 'Get By Tomorrow',
      color: Colors.blue,
    ),
    const FilterChipData(
      label: 'Avg. Customer Review',
      color: Colors.orange,
    ),
    const FilterChipData(
      label: 'Sort By Relevance',
      color: Colors.purple,
    ),
  ];
}
