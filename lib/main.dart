import 'package:flutter/material.dart';
import 'package:expense_tracker/core/core.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services here if needed:
  await StorageService.init();

  runApp(const MyApp());
}
