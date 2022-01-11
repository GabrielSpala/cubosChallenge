import 'package:app/models/credits.dart';
import 'package:app/models/movie_details.dart';
import 'package:app/services/movie_service.dart';
import 'package:app/views/search/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailsController extends GetxController {
  RxBool loading = true.obs;

  Rx<MovieDetails>? movieDetails = MovieDetails().obs;

  Rx<Credits>? movieCredits = Credits().obs;

  var formatter = NumberFormat.currency(locale: "en_US", symbol: "");

  @override
  void onInit() async {
    await getMovieDetails();
    await getMovieCredits();
    super.onInit();
    debugPrint('DetailsController - onInit');
  }

  Future<bool> getMovieDetails() async {
    final response = await Get.find<MovieService>()
        .getMovieDetails(Get.find<SearchController>().selectedMovie.id);
    movieDetails!.value = response!;
    return true;
  }

  Future<bool> getMovieCredits() async {
    final response = await Get.find<MovieService>()
        .getMovieCredits(Get.find<SearchController>().selectedMovie.id);
    movieCredits!.value = response!;
    loading.value = false;
    return true;
  }

  String returnCompanies() {
    String concatenate = "";

    for (var item in movieDetails!.value.productionCompanies!) {
      concatenate += (item.name ?? "");
      concatenate += ", ";
    }

    concatenate.isNotEmpty
        ? concatenate = concatenate.substring(0, concatenate.length - 2)
        : null;

    return concatenate;
  }

  String returnActors() {
    String concatenate = "";

    for (var item in movieCredits!.value.cast!) {
      if (item.knownForDepartment == "Acting") {
        concatenate += (item.name ?? "");
        concatenate += ", ";
      }
    }

    concatenate.isNotEmpty
        ? concatenate = concatenate.substring(0, concatenate.length - 2)
        : null;

    return concatenate;
  }

  String returnDirectors() {
    String concatenate = "";

    for (var item in movieCredits!.value.crew!) {
      if (item.knownForDepartment == "Directing") {
        concatenate += (item.name ?? "");
        concatenate += ", ";
      }
    }
    concatenate.isNotEmpty
        ? concatenate = concatenate.substring(0, concatenate.length - 2)
        : null;

    return concatenate;
  }
}
