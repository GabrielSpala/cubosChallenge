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

  final _genresFilter = 28.obs;

  List<Movies> movies = <Movies>[].obs;

  List<Genres>? genresList = <Genres>[];

  Movies selectedMovie = Movies();

  get genresFilter => _genresFilter.value;
  set genresFilter(value) => _genresFilter.value = value;

  setGenresFilter(int value) {
    genresFilter = value;
  }

  @override
  Future<void> onEndScroll() async {
    debugPrint('onEndScroll');
    if (!lastPage) {
      currentPage += 1;
      Get.dialog(const Center(child: CircularProgressIndicator()));
      await getMoviesData();
      Get.back();
    } else {
      Get.snackbar('Ops...', 'Não há mais Filmes');
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
    var listaDeGeneros = await Get.find<MovieService>().getGenres();
    genresList!.clear();
    genresList!.addAll(listaDeGeneros!.genres as List<Genres>);
    debugPrint(listaDeGeneros.toJson().toString());
  }

  Future<bool> getMoviesData({bool isRefresh = false}) async {
    if (isRefresh) {
      movies.clear();
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
        if (movie.genreIds!.any((element) => genresFilter == element)) {
          newResponse.add(movie);
        }
      }

      if (isRefresh && newResponse.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        movies.addAll(newResponse);
        change(movies, status: RxStatus.success());
      }

      currentPage = response.page!;
      totalPages = response.totalPages!;
      debugPrint(response.toJson().toString());

      if (movies.length <= 10 && !lastPage) {
        currentPage++;
        getMoviesData();
      }

      return true;
    } catch (e) {
      change(null,
          status: RxStatus.error(
              "Algo de errado aconteceu, verifique sua conexão com a internet..."));
      return false;
    }
  }

  String returnGenres(List<int>? list) {
    String concatenate = '';
    for (var item in list!) {
      concatenate +=
          (genresList!.firstWhere((element) => element.id == item).name ?? '');
      concatenate += ' - ';
    }
    concatenate = concatenate.substring(0, concatenate.length - 3);
    return concatenate;
  }
}
