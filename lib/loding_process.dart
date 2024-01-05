import 'package:flutter/material.dart';

void showLoadingDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        )),
  );
}

void hideLoadingDialog(context) {
  Navigator.pop(context);
}
