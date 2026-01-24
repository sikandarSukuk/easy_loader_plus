part of easy_loader_plus;

class EasyLoaderController extends ValueNotifier<EasyLoaderValue> {
  EasyLoaderController() : super(EasyLoaderValue.hidden());

  final EasyLoaderOverlay _overlay = EasyLoaderOverlay();

  Future<void> show({
    String? status,
    Widget? indicator,
    bool? dismissOnTap,
    EasyLoaderStyle? style,
  }) async {
    value = value.copyWith(
      isShow: true,
      status: status,
      indicator: indicator,
      dismissOnTap: dismissOnTap,
      style: style,
      duration: null, // Ensure normal show doesn't have a duration
    );
  }

  Future<void> dismiss() async {
    value = value.copyWith(isShow: false);
  }

  Future<void> success(String status, {Duration? duration}) async {
    value = value.copyWith(
      isShow: true,
      status: status,
      indicator: const Icon(Icons.check, color: Colors.white),
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  Future<void> error(String status, {Duration? duration}) async {
    value = value.copyWith(
      isShow: true,
      status: status,
      indicator: const Icon(Icons.close, color: Colors.white),
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  Future<void> info(String status, {Duration? duration}) async {
    value = value.copyWith(
      isShow: true,
      status: status,
      indicator: const Icon(Icons.info, color: Colors.white),
      duration: duration ?? const Duration(seconds: 2),
    );
  }
}

class EasyLoaderValue {
  final bool isShow;
  final String? status;
  final Widget? indicator;
  final bool? dismissOnTap;
  final EasyLoaderStyle? style;
  final Duration? duration;

  EasyLoaderValue({
    required this.isShow,
    this.status,
    this.indicator,
    this.dismissOnTap,
    this.style,
    this.duration,
  });

  EasyLoaderValue.hidden()
      : isShow = false,
        status = null,
        indicator = null,
        dismissOnTap = null,
        style = null,
        duration = null;

  EasyLoaderValue copyWith({
    bool? isShow,
    String? status,
    Widget? indicator,
    bool? dismissOnTap,
    EasyLoaderStyle? style,
    // Use a helper class to distinguish between null and not provided
    // This allows clearing the duration by passing null.
    dynamic duration,
  }) {
    return EasyLoaderValue(
      isShow: isShow ?? this.isShow,
      status: status ?? this.status,
      indicator: indicator ?? this.indicator,
      dismissOnTap: dismissOnTap ?? this.dismissOnTap,
      style: style ?? this.style,
      duration: duration == null ? null : duration as Duration?,
    );
  }
}
