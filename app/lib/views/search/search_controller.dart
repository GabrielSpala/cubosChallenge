import 'package:app/models/genres.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/movie_data.dart';
import '../../services/dio.dart';

class HomeController extends GetxController
    with StateMixin<List<Movies>>, ScrollMixin {
  final DioClient _client = DioClient();

  TextEditingController textController = TextEditingController();

  int currentPage = 1;

  var acao = false.obs;

  var aventura = false.obs;

  var fantasia = false.obs;

  var comedia = false.obs;

  late int totalPages;

  bool lastPage = false;

  List<int> genresFilter = <int>[].obs;

  List<Movies> movies = <Movies>[].obs;

  List<Genres>? genresList = <Genres>[];

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
    debugPrint('HomeController - onInit');
  }

  @override
  void onClose() {
    debugPrint('HomeController - onClose');
    super.onClose();
  }

  Future getGenres() async {
    GenresData? response = await _client.getGenres();

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
        response = await _client.getTopMovies(page: currentPage);
      } else {
        response = await _client.searchMovies(
            page: currentPage, search: textController.text);
      }

      List<Movies> newResponse = <Movies>[];
      if (genresFilter.isNotEmpty) {
        for (var movie in response!.results!) {
          if (movie.genreIds!
              .any((element) => genresFilter.contains(element))) {
            newResponse.add(movie);
          }
        }
      } else {
        newResponse.addAll(response!.results ?? <Movies>[]);
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
          acao.value = !acao.value;
          genresFilter.contains(28)
              ? genresFilter.removeWhere((element) => element == 28)
              : genresFilter.add(28);
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;

      case 12:
        {
          aventura.value = !aventura.value;
          genresFilter.contains(12)
              ? genresFilter.removeWhere((element) => element == 12)
              : genresFilter.add(12);
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;

      case 14:
        {
          fantasia.value = !fantasia.value;
          genresFilter.contains(14)
              ? genresFilter.removeWhere((element) => element == 14)
              : genresFilter.add(14);
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;
      case 35:
        {
          comedia.value = !comedia.value;
          genresFilter.contains(35)
              ? genresFilter.removeWhere((element) => element == 35)
              : genresFilter.add(35);
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;
    }
  }
}
