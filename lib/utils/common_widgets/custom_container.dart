import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;

  final String? boxcolor;
  final double? borderwidth;
  final double? borderradius;
  final Color? bordercolor;
  final Gradient? gradient;
  final Image? image;

  final List<BoxShadow>? boxshadow;
  final Function()? ontap;
  final Widget? child;
  const CustomContainer({
    super.key,
    this.bordercolor,
    this.height,
    this.width,
    this.boxcolor,
    this.borderradius,
    this.borderwidth,
    this.image,
    this.child,
    this.ontap,
    this.gradient,
    this.boxshadow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        // width: width ?? MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          border:
              Border.all(color: bordercolor ?? Colors.transparent, width: 2),
          gradient: gradient,
          boxShadow: boxshadow,
          color: HexColor(boxcolor ?? 'FFFFFF'),
          borderRadius: BorderRadius.circular(borderradius ?? 25.r),
        ),
        child: child,
      ),
    );
  }
}
