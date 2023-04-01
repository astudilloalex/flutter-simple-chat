import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat/ui/pages/home/controllers/home_controller.dart';

class BarcodeView extends StatelessWidget {
  const BarcodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          BarcodeWidget(
            data: controller.currentUser?.uid ?? '',
            barcode: Barcode.qrCode(),
            height: 250.0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          SelectableText(
            controller.currentUser?.uid ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
