import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/domain/notifiers/dashboard_book_state_notifier.dart';

final dashboardBookStateNotifierProvider =
    StateNotifierProvider<DashboardBookStateNotifier, BookModel?>(
  (ref) => DashboardBookStateNotifier(),
);
