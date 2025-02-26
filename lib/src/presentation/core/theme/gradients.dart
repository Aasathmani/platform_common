import 'package:flutter/material.dart';

Gradient topToBottomLinearGradient(BuildContext context) {
  return LinearGradient(
    colors: [
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColorLight,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

Gradient buttonGradient(BuildContext context) {
  return LinearGradient(
    colors: [
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColorLight,
    ],
  );
}
