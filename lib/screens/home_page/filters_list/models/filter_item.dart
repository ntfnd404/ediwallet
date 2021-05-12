import 'package:equatable/equatable.dart';

class FilterItem extends Equatable {
  final String name;
  final bool isSelected;

  const FilterItem({required this.name, this.isSelected = false});

  @override
  List<Object?> get props => [name, isSelected];

  Map<String, String> toJson() {
    return {
      'name': "'$name'",
      'isSelected': isSelected.toString(),
    };
  }

  FilterItem copyWith({bool? isSelected}) {
    return FilterItem(name: name, isSelected: isSelected ?? this.isSelected);
  }
}
