import 'package:get/get.dart';
import './search_controller.dart';

class HomeBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<SearchController>(
      SearchController(),
      permanent: false,
    );
  }
}
