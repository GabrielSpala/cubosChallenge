import 'package:app/application/application_pages.dart';
import 'package:app/models/movie_data.dart';
import 'package:app/views/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/movie_banner_widget.dart';
import 'components/movie_genre_badge_widget.dart';

class SearchView extends StatefulWidget {
  final String title = 'SearchView';

  const SearchView({Key? key}) : super(key: key);
  @override
  _SearchViewState createState() => _SearchViewState();
}

List<Map<String, dynamic>> genreList = [
  {
    'name': 'Ação',
    'code': 28,
  },
  {
    'name': 'Aventura',
    'code': 12,
  },
  {
    'name': 'Fantasia',
    'code': 14,
  },
  {
    'name': 'Comedia',
    'code': 35,
  },
];

class _SearchViewState extends State<SearchView> with RouteAware {
  SearchController controller = Get.find<SearchController>();

  @override
  void initState() {
    super.initState();
    debugPrint('SearchView - initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    debugPrint('SearchView - didChangeDependencies');

    Get.find<RouteObserver>().subscribe(
      this,
      ModalRoute.of(context) as PageRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('SearchView - build');
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          title: Text(
            'Filmes',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: TextFormField(
                  controller: controller.textController,
                  onChanged: (value) {
                    controller.getMoviesData(isRefresh: true);
                  },
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Pesquise filmes',
                    contentPadding: const EdgeInsets.all(0),
                    prefixIcon: Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                      child: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    fillColor: const Color.fromARGB(255, 241, 243, 245),
                    focusColor: Colors.red,
                    hoverColor: Colors.yellow,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 241, 243, 245)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 241, 243, 245)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 241, 243, 245)),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: genreList.map(
                      (e) {
                        return MovieGenreBadgeWidget(
                          label: e['name'],
                          selected: (controller.genresFilter == e['code']),
                          onTap: () {
                            controller.setGenresFilter(e['code']);
                            controller.getMoviesData(isRefresh: true);
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              Expanded(
                child: controller.obx(
                  (state) => ListView.separated(
                    separatorBuilder: (context, i) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    controller: controller.scroll,
                    itemCount: state!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final Movies list = state[index];
                      return MovieBannerWidget(
                          onTap: () => {
                                debugPrint("aaaaa"),
                                controller.selectedMovie = list,
                                Get.toNamed(ApplicationRoutes.detailsView),
                              },
                          movie: list);
                    },
                  ),
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onEmpty: const Center(
                    child: Text(
                      'Nenhum filme foi encontrado...',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onError: (error) => Center(
                    child: Text(
                      'Ops! \n\n$error',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
