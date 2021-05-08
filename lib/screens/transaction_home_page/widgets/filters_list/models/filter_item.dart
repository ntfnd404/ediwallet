class FilterItem {
  final String name;
  bool isSelected;

  FilterItem({required this.name, this.isSelected = false});

  Map<String, String> toJson() {
    return {
      'name': "'$name'",
      'isSelected': isSelected.toString(),
    };
  }
}
