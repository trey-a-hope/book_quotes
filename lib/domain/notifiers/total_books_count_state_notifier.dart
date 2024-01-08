import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/data/services/firestore_book_service.dart';

class TotalBooksCountStateNotifier extends StateNotifier<int> {
  final GetStorage _getStorage = Get.find();
  final FirestoreBookService _firestoreBookService = Get.find();

  late String _uid;

  TotalBooksCountStateNotifier() : super(0) {
    _uid = _getStorage.read('uid');
    _getTotalBookCount();
  }

  void _getTotalBookCount() async =>
      state = await _firestoreBookService.getTotalBookCount(uid: _uid);

  void increment() => state++;

  void decrement() => state--;
}