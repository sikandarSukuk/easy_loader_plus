part of easy_loader_plus;

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

  static EasyLoaderTheme of(BuildContext context, EasyLoaderStyle? style) {
    if (style == EasyLoaderStyle.custom) {
      return EasyLoaderTheme.light; // Replace with custom theme
    } else if (style == EasyLoaderStyle.dark) {
      return EasyLoaderTheme.dark;
    } else {
      return Theme.of(context).brightness == Brightness.dark
          ? EasyLoaderTheme.dark
          : EasyLoaderTheme.light;
    }
  }
}
