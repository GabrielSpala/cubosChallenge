import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'application_bindings.dart';
import 'application_pages.dart';

class ApplicationWidget extends StatefulWidget {
  const ApplicationWidget({Key? key}) : super(key: key);
  @override
  _ApplicationWidgetState createState() => _ApplicationWidgetState();
}

class _ApplicationWidgetState extends State<ApplicationWidget> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movies Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      navigatorKey: Get.key,
      navigatorObservers: [
        Get.find<RouteObserver>(),
      ],
      getPages: ApplicationPages.routes,
      initialRoute: ApplicationPages.initialRoute,
      enableLog: true,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      defaultTransition: Transition.fadeIn,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialBinding: ApplicationBinding(),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}
