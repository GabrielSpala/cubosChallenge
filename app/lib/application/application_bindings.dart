import 'package:app/services/movie_service.dart';
import 'package:get/get.dart';

class ApplicationBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<MovieService>(
      MovieService(),
      permanent: true,
    );
  }
}
