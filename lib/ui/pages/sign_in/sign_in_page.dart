import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_chat/ui/pages/sign_in/controllers/sign_in_controller.dart';
import 'package:simple_chat/ui/routes/route_name.dart';
import 'package:simple_chat/ui/widgets/google_ads/google_banner_ad.dart';
import 'package:simple_chat/ui/widgets/snackbars/snackbars.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.put(SignInController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const GoogleBannerAd(adSize: AdSize.fullBanner),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/simple_chat_icon.png',
                        width: 200.0,
                      ),
                    ),
                  ),
                  Center(
                    child: Obx(
                      () {
                        return OutlinedButton.icon(
                          onPressed: controller.loading
                              ? null
                              : () async {
                                  final String? error =
                                      await controller.signInWithGoogle();
                                  if (error != null && context.mounted) {
                                    showErrorSnackbar(context, error);
                                  } else if (context.mounted) {
                                    context.goNamed(RouteName.home);
                                  }
                                },
                          icon: controller.loading
                              ? const SizedBox(
                                  width: 18.0,
                                  height: 18.0,
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : const Icon(Icons.g_mobiledata),
                          label: Text(
                            AppLocalizations.of(context)!.continueWithGoogle,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const GoogleBannerAd(adSize: AdSize.fullBanner),
          ],
        ),
      ),
    );
  }
}
