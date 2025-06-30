import 'package:flutter/material.dart';

void showSnackbar(BuildContext ctx, String content) {
  ScaffoldMessenger.of(ctx)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(content)));
}
