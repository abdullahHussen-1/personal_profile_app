import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String text,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Row(
            children: [
              CircularProgressIndicator(color: theme.primaryColor),
              const SizedBox(width: 20),
              Expanded(child: Text(text, style: theme.textTheme.bodyLarge)),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    List<Widget>? actions,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: title != null
              ? Text(title, style: theme.textTheme.headlineMedium)
              : null,
          content: Text(message, style: theme.textTheme.bodyLarge),
          actions:
              actions ??
              [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
              ],
        );
      },
    );
  }
}
