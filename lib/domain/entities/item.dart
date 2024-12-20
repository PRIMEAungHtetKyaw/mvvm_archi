class Item {
  final String id;
  final String title;
  final String description;

  Item({required this.id, required this.title, required this.description});

  // Add copyWith method
  Item copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
