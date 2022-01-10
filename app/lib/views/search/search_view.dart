import 'package:app/models/movie_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './search_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../application/application_pages.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with RouteAware {
  HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    debugPrint('HomeView - initState');
  }

  @override
  void activate() {
    super.activate();
    debugPrint('HomeView - activate');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    debugPrint('HomeView - didChangeDependencies');

    Get.find<RouteObserver>().subscribe(
      this,
      ModalRoute.of(context) as PageRoute,
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    debugPrint('HomeView - reassemble');
  }

  @override
  void didPush() {
    debugPrint('HomeView - didPush');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('HomeView - build');
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Filmes'),
            ),
            body: Column(
              children: [
                TextFormField(
                  controller: controller.textController,
                  onChanged: (value) {
                    controller.getMoviesData(isRefresh: true);
                  },
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(
                                          color: Colors.blue))),
                              backgroundColor: MaterialStateProperty.all(
                                  controller.acao.value
                                      ? Colors.blue
                                      : Colors.white),
                            ),
                            onPressed: () {
                              controller.categoryOnTap(28);
                            },
                            child: const Text(
                              "Ação",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(
                                          color: Colors.blue))),
                              backgroundColor: MaterialStateProperty.all(
                                  controller.aventura.value
                                      ? Colors.blue
                                      : Colors.white),
                            ),
                            onPressed: () {
                              controller.categoryOnTap(12);
                            },
                            child: const Text(
                              "Aventura",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(
                                          color: Colors.blue))),
                              backgroundColor: MaterialStateProperty.all(
                                  controller.fantasia.value
                                      ? Colors.blue
                                      : Colors.white),
                            ),
                            onPressed: () {
                              controller.categoryOnTap(14);
                            },
                            child: const Text(
                              "Fantasia",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(
                                          color: Colors.blue))),
                              backgroundColor: MaterialStateProperty.all(
                                  controller.comedia.value
                                      ? Colors.blue
                                      : Colors.white),
                            ),
                            onPressed: () {
                              controller.categoryOnTap(35);
                            },
                            child: const Text(
                              "Comédia",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: controller.obx(
                    (state) => ListView.builder(
                      controller: controller.scroll,
                      itemCount: state?.length,
                      itemBuilder: (context, index) {
                        final Movies list = state![index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 20,
                              right: MediaQuery.of(context).size.width / 20,
                              bottom: MediaQuery.of(context).size.height / 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: MediaQuery.of(context).size.height / 1.5,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500' +
                                      list.posterPath!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25.0),
                                      bottomRight: Radius.circular(25.0),
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 15.0),
                                          child: Text(
                                            list.title ?? "No Title",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Row(children: [
                                          Text(
                                              "${controller.returnGenres(list.genreIds)}",
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ]),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    onLoading: const Center(child: CircularProgressIndicator()),
                    onEmpty: const Center(
                      child: Text(
                        'Movies not found',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onError: (error) => Center(
                      child: Text(
                        'Error: Cannot get repositories \n$error',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  @override
  void didPushNext() {
    debugPrint('HomeView - didPushNext');
  }

  @override
  void didPopNext() {
    debugPrint('HomeView - didPopNext');
  }

  @override
  void didPop() {
    debugPrint('HomeView - didPop');
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint('HomeView - deactivate');
  }

  @override
  void dispose() {
    Get.find<RouteObserver>().unsubscribe(this);
    super.dispose();
    debugPrint('HomeView - dispose');
  }
}

Widget categoryButton(HomeController controller, String text, bool category) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(color: Colors.blue))),
          backgroundColor:
              MaterialStateProperty.all(category ? Colors.blue : Colors.white),
        ),
        onPressed: () {
          category = !category;
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        )),
  );
}
