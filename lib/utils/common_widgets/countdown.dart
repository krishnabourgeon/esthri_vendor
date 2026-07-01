import 'dart:async';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';

class CountDown extends StatefulWidget {
  final int seconds;
  final Duration interval;
  final VoidCallback? onTap;
  final bool? resendState;
  final ValueNotifier<int> currentMicroSeconds;

  const CountDown({
    Key? key,
    required this.seconds,
    required this.currentMicroSeconds,
    this.onTap,
    this.resendState = false,
    this.interval = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  CountDownState createState() => CountDownState();
}

class CountDownState extends State<CountDown> {
  final int _secondsFactor = 1000000;
  late ValueNotifier<int> _currentMicroSeconds;
  Timer? _timer;
  bool _onFinishedExecuted = false;

  @override
  void initState() {
    _currentMicroSeconds = widget.currentMicroSeconds;
    _startTimer();
    super.initState();
  }

  @override
  void didUpdateWidget(CountDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.seconds != widget.seconds) {
      _currentMicroSeconds.value = widget.seconds * _secondsFactor;
    }
  }

  @override
  void dispose() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: _currentMicroSeconds,
        builder: (context, value, _) {
          int count = value ~/ _secondsFactor;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.r),
            child: count != 0 && !widget.resendState!
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("resend otp in",
                          style: FontPalette.lightGrey12Regular),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.r, vertical: 10.r),
                        child: count < 10
                            ? Text("0:${count.toString().padLeft(2, '0')}",
                                style: FontPalette.lightGrey12Regular
                                    .copyWith(color: HexColor("#00C159")))
                            : Text("0:${count.toString().padLeft(2, '0')}",
                                style: FontPalette.lightGrey12Regular
                                    .copyWith(color: HexColor("#00C159"))),
                      ),
                    ],
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("If you dont't receive code?"),
                        InkWell(
                          borderRadius: BorderRadius.circular(5.r),
                          onTap: () {
                            _onTimerRestart();
                            if (widget.onTap != null) widget.onTap!();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.r, vertical: 10.r),
                            child: Text(
                              "Resend",
                              style: FontPalette.blue13500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }

  void _onTimerRestart() {
    _onFinishedExecuted = false;
    _currentMicroSeconds.value = widget.seconds * _secondsFactor;
    _startTimer();
  }

  void _startTimer() {
    if (_timer?.isActive == true) {
      _timer!.cancel();
    }

    if (_currentMicroSeconds.value != 0) {
      _timer = Timer.periodic(
        widget.interval,
        (Timer timer) {
          if (_currentMicroSeconds.value <= 0) {
            timer.cancel();
            _onFinishedExecuted = true;
          } else {
            _currentMicroSeconds.value =
                _currentMicroSeconds.value - widget.interval.inMicroseconds;
          }
        },
      );
    } else if (!_onFinishedExecuted) {
      _onFinishedExecuted = true;
    }
  }
}
