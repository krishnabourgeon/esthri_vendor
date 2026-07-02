import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.isLoading,
      this.fontStyle,
      this.onTap,
      this.text,
      this.height,
      this.width,
      this.color});
  final ValueNotifier<bool>? isLoading;
  final Function()? onTap;
  final String? text;
  final double? height;
  final double? width;
  final TextStyle? fontStyle;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isLoading ?? ValueNotifier<bool>(false),
      builder: (context, value, child) => InkWell(
        splashColor: Colors.white,
        highlightColor: Colors.white,
        onTap: onTap,
        child: Container(
          height: height ?? 48.h,
          width: width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.r),
              color: color ?? AppColors.primaryDark),
          child: Center(
              child: isLoading?.value == true
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      text ?? '',
                      style: fontStyle ?? FontPalette.black13500,
                    )),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color? shadowColor;
  final bool? enabled;
  final TextStyle? fontStyle;
  final double? borderRadius;
  final Color? color;

  const CustomButton2({
    Key? key,
    this.height,
    this.width,
    this.child,
    this.isLoading = false,
    this.onPressed,
    this.shadowColor,
    this.enabled = true,
    this.fontStyle,
    this.borderRadius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.h,
      width: width ?? double.maxFinite,
      child: ElevatedButton(
        onPressed: isLoading || !enabled! ? null : onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 11.r),
          )),
          enableFeedback: enabled,
          backgroundColor: !enabled!
              ? WidgetStateProperty.all(Colors.grey.shade300)
              : WidgetStateProperty.all(color ?? HexColor("#FF165D")),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? SizedBox.square(
                  dimension: (height ?? 45.h) - 15,
                  child: const CircularProgressIndicator(color: Colors.white))
              : FittedBox(child: child),
        ),
      ),
    );
  }
}

class CustomButton3 extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color? shadowColor;
  final bool? enabled;
  final TextStyle? fontStyle;
  final double? borderRadius;
  final Color? color;

  const CustomButton3({
    Key? key,
    this.height,
    this.width,
    this.title,
    this.isLoading = false,
    this.onPressed,
    this.shadowColor,
    this.enabled = true,
    this.fontStyle,
    this.borderRadius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.h,
      width: width ?? double.maxFinite,
      child: ElevatedButton(
        onPressed: isLoading || !enabled! ? null : onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 11.r),
          )),
          enableFeedback: enabled,
          backgroundColor: !enabled!
              ? WidgetStateProperty.all(Colors.grey.shade300)
              : WidgetStateProperty.all(
                  color ?? const Color.fromRGBO(23, 122, 99, 1)),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? SizedBox.square(
                  dimension: (height ?? 45.h) - 15,
                  child: const CircularProgressIndicator(color: Colors.white))
              : FittedBox(
                  child: Text(
                    (title ?? ""),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: fontStyle ?? FontPalette.black13500,
                  ),
                ),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color? shadowColor;
  final bool? enabled;
  final TextStyle? fontStyle;
  final double? borderRadius;
  final Color? color;

  const CustomOutlineButton({
    Key? key,
    this.height,
    this.width,
    this.title,
    this.isLoading = false,
    this.onPressed,
    this.shadowColor,
    this.enabled = true,
    this.fontStyle,
    this.borderRadius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.h,
      width: width ?? double.maxFinite,
      child: OutlinedButton(
        onPressed: isLoading || !enabled! ? null : onPressed,
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: color ?? Colors.black),
            backgroundColor: !enabled! ? Colors.red.shade300 : Colors.blue,
            foregroundColor:
                !enabled! ? Colors.grey.shade100 : Colors.transparent,
            enableFeedback: enabled,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: color ?? Colors.black),
                borderRadius: BorderRadius.circular(borderRadius ?? 11.r))),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? const CircularProgressIndicator()
              : FittedBox(
                  child: Text(
                    (title ?? ""),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: fontStyle ??
                        FontPalette.black13500.copyWith(color: color),
                  ),
                ),
        ),
      ),
    );
  }
}

String convert(String? time) {
  DateTime parsedDate = DateTime.parse(time.toString());
  return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
}
