import 'package:app/models/genres.dart';
import 'package:app/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/movie_data.dart';

class SearchController extends GetxController
    with StateMixin<List<Movies>>, ScrollMixin {
  TextEditingController textController = TextEditingController();

  int currentPage = 1;

  late int totalPages;

  bool lastPage = false;

  RxInt genresFilter = 28.obs;

  List<Movies> movies = <Movies>[].obs;

  List<Genres>? genresList = <Genres>[];

  Movies selectedMovie = Movies();

  @override
  Future<void> onEndScroll() async {
    debugPrint('onEndScroll');
    if (!lastPage) {
      currentPage += 1;
      Get.dialog(const Center(child: CircularProgressIndicator()));
      await getMoviesData();
      Get.back();
    } else {
      Get.snackbar('Alert', 'End of Repositories');
    }
  }

  @override
  Future<void> onTopScroll() async {
    debugPrint('onTopScroll');
  }

  @override
  void onInit() async {
    await getGenres();
    await getMoviesData(isRefresh: true);
    super.onInit();
    debugPrint('SearchController - onInit');
  }

  @override
  void onClose() {
    debugPrint('SearchController - onClose');
    super.onClose();
  }

  Future getGenres() async {
    GenresData? response = await Get.find<MovieService>().getGenres();

    genresList = response!.genres!.cast<Genres>();
  }

  Future<bool> getMoviesData({bool isRefresh = false}) async {
    if (isRefresh) {
      change(null, status: RxStatus.loading());
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        lastPage = true;
        return false;
      }
      lastPage = false;
    }

    try {
      MovieData? response;

      if (textController.text == "") {
        response =
            await Get.find<MovieService>().getTopMovies(page: currentPage);
      } else {
        response = await Get.find<MovieService>()
            .searchMovies(page: currentPage, search: textController.text);
      }

      List<Movies> newResponse = <Movies>[];

      for (var movie in response!.results!) {
        if (movie.genreIds!.any((element) => genresFilter.value == element)) {
          newResponse.add(movie);
        }
      }

      if (isRefresh && newResponse.isEmpty) {
        movies.clear();
        change(null, status: RxStatus.empty());
      } else if (isRefresh) {
        movies = newResponse;
        change(movies, status: RxStatus.success());
      } else {
        movies.addAll(newResponse);
        change(movies, status: RxStatus.success());
      }

      currentPage = response.page!;

      totalPages = response.totalPages!;

      debugPrint(response.toJson().toString());

      if (movies.length <= 10) {
        currentPage++;
        getMoviesData();
      }

      return true;
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      return false;
    }
  }

  categoryOnTap(int id) {
    switch (id) {
      case 28:
        {
          genresFilter.value = 28;
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;

      case 12:
        {
          genresFilter.value = 12;
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;

      case 14:
        {
          genresFilter.value = 14;
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;
      case 35:
        {
          genresFilter.value = 35;
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;
    }
  }

  String returnGenres(List<int>? list) {
    String concatenate = "";

    for (var item in list!) {
      concatenate +=
          (genresList!.firstWhere((element) => element.id == item).name ?? "");
      concatenate += " - ";
    }

    concatenate = concatenate.substring(0, concatenate.length - 3);

    return concatenate;
  }
}
