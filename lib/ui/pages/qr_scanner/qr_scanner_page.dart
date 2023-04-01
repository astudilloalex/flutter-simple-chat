import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 8.0,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.9,
                child: MobileScanner(
                  controller: _scannerController,
                  fit: BoxFit.none,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final Barcode barcode in barcodes) {
                      context.pop(barcode.rawValue);
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 30.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: _scannerController.torchState,
                      builder: (context, state, child) {
                        if (state == TorchState.off) {
                          return const Icon(Icons.flash_off);
                        }
                        return const Icon(
                          Icons.flash_on,
                        );
                      },
                    ),
                    onPressed: () {
                      _scannerController.toggleTorch();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
