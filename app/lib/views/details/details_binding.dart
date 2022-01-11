import 'package:get/get.dart';
import 'details_controller.dart';

class DetailsBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<DetailsController>(
      DetailsController(),
      permanent: false,
    );
  }
}
