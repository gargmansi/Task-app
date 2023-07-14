import 'package:flutter/material.dart';

Future<void> loadinDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => const AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    ),
  );
}
