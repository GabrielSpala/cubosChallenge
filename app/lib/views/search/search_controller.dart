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

  RxInt genresFilter = 28.obs;

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

  categoryOnTap(int index) {
    switch (index) {
      case 0:
        {
          acao.value = !acao.value;
          genresFilter.value = 28;
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;

      case 1:
        {
          aventura.value = !aventura.value;
          genresFilter.value = 12;
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;

      case 2:
        {
          fantasia.value = !fantasia.value;
          genresFilter.value = 14;
          debugPrint(genresFilter.toString());
          getMoviesData(isRefresh: true);
        }
        break;
      case 3:
        {
          comedia.value = !comedia.value;
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
