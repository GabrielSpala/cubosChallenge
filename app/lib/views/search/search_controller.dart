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

  List<int> genres = <int>[].obs;

  List<Movies> movies = <Movies>[].obs;

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
  void onInit() {
    getMoviesData(isRefresh: true);
    super.onInit();
    debugPrint('HomeController - onInit');
  }

  @override
  void onClose() {
    debugPrint('HomeController - onClose');
    super.onClose();
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
      final response = await _client.getTopMovies(page: currentPage);

      List<Movies> newResponse = <Movies>[];
      if (genres.isNotEmpty) {
        for (var movie in response!.results!) {
          if (movie.genreIds!.any((element) => genres.contains(element))) {
            newResponse.add(movie);
          }
        }
      } else {
        newResponse.addAll(response!.results ?? <Movies>[]);
      }

      if (isRefresh && newResponse.isEmpty) {
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
          genres.contains(28)
              ? genres.removeWhere((element) => element == 28)
              : genres.add(28);
          debugPrint(genres.toString());
          getMoviesData(isRefresh: true);
        }
        break;

      case 12:
        {
          aventura.value = !aventura.value;
          genres.contains(12)
              ? genres.removeWhere((element) => element == 12)
              : genres.add(12);
          debugPrint(genres.toString());
          getMoviesData(isRefresh: true);
        }
        break;

      case 14:
        {
          fantasia.value = !fantasia.value;
          genres.contains(14)
              ? genres.removeWhere((element) => element == 14)
              : genres.add(14);
          debugPrint(genres.toString());
          getMoviesData(isRefresh: true);
        }
        break;
      case 35:
        {
          comedia.value = !comedia.value;
          genres.contains(35)
              ? genres.removeWhere((element) => element == 35)
              : genres.add(35);
          debugPrint(genres.toString());
          getMoviesData(isRefresh: true);
        }
        break;
    }
  }
}
