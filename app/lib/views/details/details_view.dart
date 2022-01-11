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
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              components.BackButton(label: "Voltar", onTap: () => Get.back()),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx(() => controller.loading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(controller.movieDetails!.value.toJson().toString())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
