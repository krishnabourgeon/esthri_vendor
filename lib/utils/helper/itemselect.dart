 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
 
class ItemIncrDerce extends StatelessWidget {
  final String? itemname;
  final double? price;
  final int? quantity;
  final Function()? increontap;
  final Function()? decreontap;
  const ItemIncrDerce(
      {super.key,
      this.itemname,
      this.price,
      this.quantity,
      this.increontap,
      this.decreontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r),
          border: Border.all(color: HexColor("#A4CFC5"))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              itemname!,
              overflow: TextOverflow.ellipsis,
              style: FontPalette.black13500,
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                Text(
                  "₹ ${price!.truncate()}",
                  style: FontPalette.black13500,
                ).rightPadding(20.w),
                InkWell(
                  onTap: decreontap,
                  child: Container(
                    height: 18.h,
                    width: 18.w,
                    decoration: BoxDecoration(
                        color: HexColor("#50BFA5"), shape: BoxShape.circle),
                    child: Center(
                        child: Container(
                      height: 1.h,
                      width: 6.w,
                      color: Colors.white,
                    )),
                  ),
                ).rightPadding(6.w),
                Text(
                  quantity.toString(),
                  style: FontPalette.black13500,
                ),
                InkWell(
                  onTap: increontap,
                  child: Container(
                    height: 18.h,
                    width: 18.w,
                    decoration: BoxDecoration(
                        color: HexColor("#50BFA5"), shape: BoxShape.circle),
                    child: const Center(
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ).leftPadding(6.w)
              ],
            ),
          )
        ],
      ).horizontalPadding(20.w),
    );
  }
}
