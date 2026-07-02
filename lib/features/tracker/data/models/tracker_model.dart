class TrackerModel {
  final int? id;
  final String title;
  final double cost;
  final String date;
  final String type; // "EXPENSE" or "INCOME"
  final String? createdAt;
  final String? updatedAt;

  TrackerModel({
    this.id,
    required this.title,
    required this.cost,
    required this.date,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory TrackerModel.fromJson(Map<String, dynamic> json) {
    double parsedCost = 0.0;
    if (json['cost'] != null) {
      parsedCost = double.tryParse(json['cost'].toString()) ?? 0.0;
    }
    return TrackerModel(
      id: json['id'],
      title: json['title'] ?? '',
      cost: parsedCost,
      date: json['date'] ?? '',
      type: json['type'] ?? 'EXPENSE',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'cost': cost,
      'date': date,
      'type': type,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }
}
