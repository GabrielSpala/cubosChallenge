import 'package:app/views/details/details_binding.dart';
import 'package:app/views/details/details_view.dart';
import 'package:get/get.dart';
import '../views/search/search_binding.dart';
import '../views/search/search_view.dart';

part 'application_routes.dart';

class ApplicationPages {
  static const initialRoute = ApplicationRoutes.searchView;

  static final routes = [
    GetPage(
      name: ApplicationRoutes.searchView,
      page: () {
        return const SearchView();
      },
      bindings: [
        HomeBinding(),
      ],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: ApplicationRoutes.detailsView,
      page: () {
        return const DetailsView();
      },
      bindings: [
        DetailsBinding(),
      ],
      transition: Transition.fadeIn,
    ),
  ];
}
