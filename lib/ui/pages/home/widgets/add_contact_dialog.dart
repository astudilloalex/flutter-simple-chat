import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat/ui/pages/home/controllers/home_controller.dart';
import 'package:simple_chat/ui/widgets/snackbars/snackbars.dart';

class AddContactDialog extends StatelessWidget {
  const AddContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.addContactId,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: controller.userIdController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            Obx(
              () {
                return ElevatedButton.icon(
                  onPressed: controller.addingContact
                      ? null
                      : () async {
                          final String? error = await controller.addContact();
                          if (error != null && context.mounted) {
                            showErrorSnackbar(context, error);
                          }
                          if (context.mounted) GoRouter.of(context).pop();
                        },
                  label: Text(AppLocalizations.of(context)!.add),
                  icon: const Icon(Icons.add),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
