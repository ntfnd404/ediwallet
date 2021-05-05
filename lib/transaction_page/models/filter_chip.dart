class FilterChipData {
  final String name;
  bool isSelected;

  FilterChipData({required this.name, this.isSelected = false});

  Map<String, String> toJson() {
    return {
      'name': "'$name'",
      'isSelected': isSelected.toString(),
    };
  }
}
