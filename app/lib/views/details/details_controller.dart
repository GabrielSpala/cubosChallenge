import 'package:app/models/movie_details.dart';
import 'package:app/services/movie_service.dart';
import 'package:app/views/search/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  RxBool loading = true.obs;

  Rx<MovieDetails>? movieDetails = MovieDetails().obs;

  @override
  void onInit() async {
    await getMovieDetails();
    super.onInit();
    debugPrint('DetailsController - onInit');
  }

  Future<bool> getMovieDetails() async {
    final response = await Get.find<MovieService>()
        .getMovieDetails(Get.find<SearchController>().selectedMovie.id);
    movieDetails!.value = response!;
    loading.value = false;
    return true;
  }
}
