import 'tracker_model.dart';

class TodayTrackerResponseModel {
  final List<TrackerModel> items;
  final double totalExpense;
  final double totalIncome;
  final double balance;

  TodayTrackerResponseModel({
    required this.items,
    required this.totalExpense,
    required this.totalIncome,
    required this.balance,
  });

  factory TodayTrackerResponseModel.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List? ?? [];
    List<TrackerModel> parsedItems = itemsList.map((i) => TrackerModel.fromJson(i)).toList();

    return TodayTrackerResponseModel(
      items: parsedItems,
      totalExpense: double.tryParse(json['totalExpense'].toString()) ?? 0.0,
      totalIncome: double.tryParse(json['totalIncome'].toString()) ?? 0.0,
      balance: double.tryParse(json['balance'].toString()) ?? 0.0,
    );
  }
}
