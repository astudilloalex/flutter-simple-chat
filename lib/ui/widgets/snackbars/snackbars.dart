import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
}
