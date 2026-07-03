import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/core/core.dart';
import '../data/models/tracker_model.dart';
import '../data/models/today_tracker_response_model.dart';

class TrackerController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  final isLoading = false.obs;
  final trackers = <TrackerModel>[].obs;

  // Today statistics
  final totalExpense = 0.0.obs;
  final totalIncome = 0.0.obs;
  final balance = 0.0.obs;

  // Controllers for bottom sheet form
  final titleController = TextEditingController();
  final costController = TextEditingController();
  final dateController = TextEditingController();
  final selectedType = "EXPENSE".obs; // "EXPENSE" or "INCOME"
  final isTodaySelected = true.obs;

  void changeSegment(bool isToday) {
    isTodaySelected.value = isToday;
    if (isToday) {
      getTodayTracker();
    } else {
      getOverallTracker();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getTodayTracker();
  }

  @override
  void onClose() {
    titleController.dispose();
    costController.dispose();
    dateController.dispose();
    super.onClose();
  }

  void clearForm() {
    titleController.clear();
    costController.clear();
    dateController.clear();
    selectedType.value = "EXPENSE";
  }

  Future<void> getTodayTracker() async {
    isLoading.value = true;
    try {
      final token = StorageService.token;
      if (token == null || token.isEmpty) return;

      final response = await _networkCaller.getRequest(
        ApiConstants.trackerToday,
        token: 'Bearer $token',
      );

      if (response.isSuccess) {
        final data = TodayTrackerResponseModel.fromJson(response.responseData);
        trackers.value = data.items;
        totalExpense.value = data.totalExpense;
        totalIncome.value = data.totalIncome;
        balance.value = data.balance;
      } else {
        Get.snackbar(
          "Error",
          response.errorMessage.isNotEmpty ? response.errorMessage : "Failed to load today's tracker.",
          backgroundColor: const Color(0xFFC84C4C),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOverallTracker() async {
    isLoading.value = true;
    try {
      final token = StorageService.token;
      if (token == null || token.isEmpty) return;

      final response = await _networkCaller.getRequest(
        ApiConstants.tracker,
        token: 'Bearer $token',
      );

      if (response.isSuccess) {
        final data = TodayTrackerResponseModel.fromJson(response.responseData);
        trackers.value = data.items;
        totalExpense.value = data.totalExpense;
        totalIncome.value = data.totalIncome;
        balance.value = data.balance;
      } else {
        Get.snackbar(
          "Error",
          response.errorMessage.isNotEmpty ? response.errorMessage : "Failed to load overall tracker.",
          backgroundColor: const Color(0xFFC84C4C),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addTracker() async {
    final title = titleController.text.trim();
    final costText = costController.text.trim();
    final date = dateController.text.trim();
    final type = selectedType.value;

    if (title.isEmpty) {
      Get.snackbar("Invalid Title", "Please enter a title.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
      return false;
    }

    final cost = double.tryParse(costText);
    if (cost == null || cost <= 0) {
      Get.snackbar("Invalid Cost", "Please enter a valid cost.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
      return false;
    }

    if (date.isEmpty) {
      Get.snackbar("Invalid Date", "Please select a date.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
      return false;
    }

    isLoading.value = true;
    try {
      final token = StorageService.token;
      if (token == null || token.isEmpty) {
        Get.snackbar("Authentication Required", "Please log in again.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
        return false;
      }

      final response = await _networkCaller.postRequest(
        ApiConstants.tracker,
        token: 'Bearer $token',
        body: {
          "title": title,
          "cost": cost,
          "date": date,
          "type": type,
        },
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Tracker added successfully!",
          backgroundColor: const Color(0xFF8A7665),
          colorText: Colors.white,
        );
        clearForm();
        // Refresh active summary statistics and lists
        if (isTodaySelected.value) {
          await getTodayTracker();
        } else {
          await getOverallTracker();
        }
        return true;
      } else {
        Get.snackbar(
          "Failed to Add",
          response.errorMessage.isNotEmpty ? response.errorMessage : "Something went wrong.",
          backgroundColor: const Color(0xFFC84C4C),
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void setFormForEdit(TrackerModel item) {
    titleController.text = item.title;
    costController.text = item.cost.toString();
    dateController.text = item.date;
    selectedType.value = item.type;
  }

  Future<bool> updateTracker(int? id) async {
    if (id == null) {
      Get.snackbar("Invalid ID", "Tracker item ID is missing.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
      return false;
    }
    final title = titleController.text.trim();
    final costText = costController.text.trim();
    final date = dateController.text.trim();
    final type = selectedType.value;

    if (title.isEmpty) {
      Get.snackbar("Invalid Title", "Please enter a title.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
      return false;
    }

    final cost = double.tryParse(costText);
    if (cost == null || cost <= 0) {
      Get.snackbar("Invalid Cost", "Please enter a valid cost.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
      return false;
    }

    if (date.isEmpty) {
      Get.snackbar("Invalid Date", "Please select a date.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
      return false;
    }

    isLoading.value = true;
    try {
      final token = StorageService.token;
      if (token == null || token.isEmpty) {
        Get.snackbar("Authentication Required", "Please log in again.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
        return false;
      }

      final response = await _networkCaller.patchRequest(
        '${ApiConstants.tracker}/$id',
        token: 'Bearer $token',
        body: {
          "title": title,
          "cost": cost,
          "date": date,
          "type": type,
        },
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Tracker updated successfully!",
          backgroundColor: const Color(0xFF8A7665),
          colorText: Colors.white,
        );
        clearForm();
        if (isTodaySelected.value) {
          await getTodayTracker();
        } else {
          await getOverallTracker();
        }
        return true;
      } else {
        Get.snackbar(
          "Failed to Update",
          response.errorMessage.isNotEmpty ? response.errorMessage : "Something went wrong.",
          backgroundColor: const Color(0xFFC84C4C),
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteTracker(int? id) async {
    if (id == null) {
      Get.snackbar("Invalid ID", "Tracker item ID is missing.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
      return false;
    }

    isLoading.value = true;
    try {
      final token = StorageService.token;
      if (token == null || token.isEmpty) {
        Get.snackbar("Authentication Required", "Please log in again.", backgroundColor: const Color(0xFFC84C4C), colorText: Colors.white);
        return false;
      }

      final response = await _networkCaller.deleteRequest(
        '${ApiConstants.tracker}/$id',
        token: 'Bearer $token',
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Tracker deleted successfully!",
          backgroundColor: const Color(0xFF8A7665),
          colorText: Colors.white,
        );
        clearForm();
        if (isTodaySelected.value) {
          await getTodayTracker();
        } else {
          await getOverallTracker();
        }
        return true;
      } else {
        Get.snackbar(
          "Failed to Delete",
          response.errorMessage.isNotEmpty ? response.errorMessage : "Something went wrong.",
          backgroundColor: const Color(0xFFC84C4C),
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color(0xFFC84C4C),
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
