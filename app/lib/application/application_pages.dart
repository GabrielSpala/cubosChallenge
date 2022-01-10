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
        return HomeView();
      },
      bindings: [
        HomeBinding(),
      ],
      transition: Transition.fadeIn,
    ),
  ];
}
