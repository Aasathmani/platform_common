import 'package:flutter/material.dart';
import 'package:platform_common/generated/l10n.dart';
import 'package:platform_common/src/presentation/widgets/dialog/app_dialog.dart';
import 'package:platform_common/src/utils/string_utils.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  void focusChange(
    BuildContext context,
    FocusNode? currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus?.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void showMessage(String? message, {Duration? time, SnackBarAction? action}) {
    if (message == null) return;

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        duration: time ?? const Duration(seconds: 2),
      ),
    );
  }

  void showMessageDialog(BuildContext context, String value) {
    if (StringUtils.isNotNullAndEmpty(value)) {
      openAppDialog(
        context,
        title: value,
        positiveButtonText: S.current.btnOk.toUpperCase(),
      );
    }
  }
}
