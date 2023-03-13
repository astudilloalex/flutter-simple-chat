import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat/ui/pages/splash/controllers/splash_controller.dart';
import 'package:simple_chat/ui/routes/route_name.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Obx(() {
            if (!controller.userLogged) {
              context.goNamed(RouteName.signIn);
            }
            if (controller.userLogged) {
              context.goNamed(RouteName.home);
            }
            if (controller.error != null) return Text(controller.error!);
            return const CircularProgressIndicator.adaptive();
          }),
        ),
      ),
    );
  }
}
