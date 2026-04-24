part of '../easy_loader_plus.dart';

class EasyLoaderTheme {
  final Color backgroundColor;
  final TextStyle textStyle;
  final double loaderSize;
  final double progressBarHeight;

  const EasyLoaderTheme({
    required this.backgroundColor,
    required this.textStyle,
    this.loaderSize = 80.0,
    this.progressBarHeight = 4.0,
  });

  static const EasyLoaderTheme light = EasyLoaderTheme(
    backgroundColor: Colors.white,
    textStyle: TextStyle(color: Colors.black),
  );

  static const EasyLoaderTheme dark = EasyLoaderTheme(
    backgroundColor: Colors.black,
    textStyle: TextStyle(color: Colors.white),
  );

  /// Spinner-only look: no panel behind the indicator.
  static EasyLoaderTheme custom(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return EasyLoaderTheme(
      backgroundColor: Colors.transparent,
      textStyle: TextStyle(
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  static EasyLoaderTheme of(BuildContext context, EasyLoaderStyle? style) {
    if (style == EasyLoaderStyle.custom) {
      return custom(context);
    } else if (style == EasyLoaderStyle.dark) {
      return EasyLoaderTheme.dark;
    } else {
      return Theme.of(context).brightness == Brightness.dark
          ? EasyLoaderTheme.dark
          : EasyLoaderTheme.light;
    }
  }
}
