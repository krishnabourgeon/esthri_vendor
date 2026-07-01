 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
 
class AppBAR extends StatelessWidget {
  final String? title;
  final Function()? ontap;
  static bool back = false;
  const AppBAR({super.key, this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        back == false
            ? InkWell(
                onTap: ontap,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#DADADA")),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Center(
                          child: const Icon(
                        Icons.arrow_back_ios,
                        size: 17,
                      ).verticalPadding(8.h).horizontalPadding(8.w)),
                    )),
              )
            : const SizedBox(),
        Text(
          title!,
          style: FontPalette.black23600,
        ),
        SizedBox(
          width: 30.w,
        )
      ],
    );
  }
}

class BackBUtton extends StatelessWidget {
  final Function()? ontap;
  const BackBUtton({super.key, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: HexColor("#DADADA")),
              shape: BoxShape.circle),
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 17,
            ).verticalPadding(8.h).horizontalPadding(8.w),
          ))),
    );
  }
}
