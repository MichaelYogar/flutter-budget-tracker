class ItemModel {
  ItemModel({
    required this.name,
    required this.category,
    required this.price,
    required this.purchaseDate,
  });

  final String name;
  final String category;
  final double price;
  final DateTime purchaseDate;

  factory ItemModel.fromJSON(Map<String, dynamic> json) {
    final properties = json['properties'] as Map<String, dynamic>;
    final nameList = (properties['Name']?['title'] ?? []) as List;
    final dateStr = properties['Date']?['date']?['start'];
    return ItemModel(
      name: nameList.isNotEmpty ? nameList[0]['plain_text'] : '?',
      category: properties['Category']?['select']?['name'] ?? 'Any',
      price: (properties['Price']?['number'] ?? 0).toDouble(),
      purchaseDate: dateStr != null ? DateTime.parse(dateStr) : DateTime.now(),
    );
  }
}
