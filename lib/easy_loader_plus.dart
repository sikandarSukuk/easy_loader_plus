library easy_loader_plus;

import 'dart:async';

import 'package:flutter/material.dart';

part 'src/controller.dart';
part 'src/overlay.dart';
part 'src/widget.dart';
part 'src/theme.dart';
part 'src/utils.dart';

enum EasyLoaderStyle {
  light,
  dark,
  custom,
}

enum EasyLoaderAnimation {
  pulse,
  wave,
  bounce,
  morph,
}

class EasyLoader {
  static final EasyLoader _singleton = EasyLoader._internal();

  factory EasyLoader() {
    return _singleton;
  }

  EasyLoader._internal();

  static EasyLoaderController? _controller;

  static EasyLoader get instance => _singleton;

  static bool get isShow => _controller?.value.isShow ?? false;

  /// init EasyLoader
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    _controller ??= EasyLoaderController();
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(
          context,
          Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (BuildContext context) => child ?? const SizedBox(),
              ),
              _controller!._overlay,
            ],
          ),
        );
      } else {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (BuildContext context) => child ?? const SizedBox(),
            ),
            _controller!._overlay,
          ],
        );
      }
    };
  }

  /// reset EasyLoader for test
  @visibleForTesting
  static void reset() {
    _controller = null;
  }

  static Future<void> show({
    String? status,
    Widget? indicator,
    bool? dismissOnTap,
    EasyLoaderStyle? style,
  }) {
    return _controller?.show(
          status: status,
          indicator: indicator,
          dismissOnTap: dismissOnTap,
          style: style,
        ) ??
        Future.value();
  }

  static Future<void> dismiss() {
    return _controller?.dismiss() ?? Future.value();
  }

  static Future<void> success(
    String status, {
    Duration? duration,
  }) {
    return _controller?.success(status, duration: duration) ?? Future.value();
  }

  static Future<void> error(
    String status, {
    Duration? duration,
  }) {
    return _controller?.error(status, duration: duration) ?? Future.value();
  }

  static Future<void> info(
    String status, {
    Duration? duration,
  }) {
    return _controller?.info(status, duration: duration) ?? Future.value();
  }
}
