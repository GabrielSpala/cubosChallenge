import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'application/application_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Get.put<RouteObserver>(
    RouteObserver<PageRoute>(),
    permanent: true,
  );

  runApp(
    const ApplicationWidget(),
  );
}
