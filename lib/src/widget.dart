part of '../easy_loader_plus.dart';

class EasyLoaderWidget extends StatefulWidget {
  const EasyLoaderWidget({Key? key}) : super(key: key);

  @override
  EasyLoaderWidgetState createState() => EasyLoaderWidgetState();
}

class EasyLoaderWidgetState extends State<EasyLoaderWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  EasyLoaderValue? _value;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    EasyLoader._controller?.addListener(_onValueChanged);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    EasyLoader._controller?.removeListener(_onValueChanged);
    super.dispose();
  }

  void _onValueChanged() {
    final value = EasyLoader._controller?.value;
    if (value != _value) {
      _timer?.cancel();
      if (value?.isShow == true) {
        _animationController.forward();
        if (value?.duration != null) {
          _timer = Timer(value!.duration!, () {
            EasyLoader.dismiss();
          });
        }
      } else {
        _animationController.reverse();
      }
      setState(() {
        _value = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _value?.isShow == true
        ? Stack(
            children: [
              GestureDetector(
                onTap: _value?.dismissOnTap == true ? EasyLoader.dismiss : null,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Center(
                child: FadeTransition(
                  opacity: _animation,
                  child: ScaleTransition(
                    scale: _animation,
                    child: _buildLoader(),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _buildLoader() {
    final theme = EasyLoaderTheme.of(context, _value?.style);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_value?.indicator != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _value!.indicator,
            ),
          if (_value?.status != null)
            Text(
              _value!.status!,
              style: theme.textStyle,
            ),
        ],
      ),
    );
  }
}
