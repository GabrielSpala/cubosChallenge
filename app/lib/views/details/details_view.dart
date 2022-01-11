import 'package:app/views/details/components/grey_row.dart';
import 'package:app/views/details/components/title_and_info.dart';
import 'package:app/views/details/details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/back_button.dart' as components;

class DetailsView extends StatefulWidget {
  const DetailsView({Key? key}) : super(key: key);
  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> with RouteAware {
  DetailsController controller = Get.find<DetailsController>();

  @override
  void initState() {
    super.initState();
    debugPrint('DetailsView - initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    debugPrint('DetailsView - didChangeDependencies');

    Get.find<RouteObserver>().subscribe(
      this,
      ModalRoute.of(context) as PageRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('DetailsView - build');
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  components.BackButton(
                      label: "Voltar", onTap: () => Get.back()),
                ]),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(
          () => controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 25.0, right: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                          ),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${controller.movieDetails!.value.posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.movieDetails!.value.voteAverage!
                                    .toStringAsFixed(1),
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 0, 56, 76),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                " / 10",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 134, 142, 150),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: Text(
                            controller.movieDetails!.value.title!.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 52, 58, 64),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Título Original: ",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 134, 142, 150),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Text(
                              controller.movieDetails!.value.originalTitle ??
                                  "No Title",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 134, 142, 150),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GreyRow(
                                  title: "Ano",
                                  text: controller
                                      .movieDetails!.value.releaseDate!
                                      .substring(0, 4)),
                              GreyRow(
                                  title: "Duração",
                                  text:
                                      "${(controller.movieDetails!.value.runtime! ~/ 60).toString()}h ${(controller.movieDetails!.value.runtime! % 60).toInt().toString()} min"),
                            ],
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: MediaQuery.of(context).size.width * 0.02,
                          runSpacing: MediaQuery.of(context).size.width * 0.02,
                          children: [
                            for (var item
                                in controller.movieDetails!.value.genres!)
                              Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.02),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 241, 243, 245),
                                  ),
                                ),
                                child: Text(
                                  item.name!.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 94, 103, 112),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        TitleAndInfo(
                            title: "Descrição",
                            text: controller.movieDetails!.value.overview ??
                                "No Description"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 241, 243, 245),
                            border: Border.all(
                              color: const Color.fromARGB(255, 241, 243, 245),
                            ),
                          ),
                          width: double.maxFinite,
                          child: Padding(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "ORÇAMENTO: ",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 134, 142, 150),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$ ${controller.formatter.format(controller.movieDetails!.value.budget)}",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 52, 58, 64),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 241, 243, 245),
                            border: Border.all(
                              color: const Color.fromARGB(255, 241, 243, 245),
                            ),
                          ),
                          width: double.maxFinite,
                          child: Padding(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "PRODUTORAS: ",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 134, 142, 150),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    controller.returnCompanies(),
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 52, 58, 64),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TitleAndInfo(
                            title: "Diretor",
                            text: controller.returnDirectors()),
                        TitleAndInfo(
                            title: "Elenco", text: controller.returnActors()),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
