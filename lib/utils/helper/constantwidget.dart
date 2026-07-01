import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
 
class ConstantWidget {
  static const emptyBox = SizedBox.shrink();
}

class LineHori extends StatelessWidget {
  final String? title;
  final Function()? ontap;
  static bool back = false;
  const LineHori({super.key, this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      width: MediaQuery.of(context).size.width,
      color: HexColor("#CACACA"),
    );
  }
}
