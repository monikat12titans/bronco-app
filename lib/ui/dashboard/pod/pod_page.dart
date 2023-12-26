import 'package:bronco_trucking/ui/dashboard/pod/pod_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PODPage extends GetResponsiveView<PODController> {
  @override
  Widget? builder() {
    // TODO: implement builder
    var podImage = Get.arguments ?? 'https://picsum.photos/250?image=9';
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            InteractiveViewer(
                panEnabled: false,
                // Set it to false
                boundaryMargin: const EdgeInsets.all(40),
                minScale: 0.5,
                maxScale: 4,
                child: Image.network(
                  podImage as String,
                  width: Get.width - 60,
                  height: Get.height * 0.8,
                )),
          ],
        ),
      ),
    );
  }
}
