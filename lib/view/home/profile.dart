import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: FontPalette.black21400,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, home, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            50.verticalSpace,
            home.profile?.user?.picture == null
                ? Container(
                    width: 92.w,
                    height: 92.h,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(238, 243, 242, 1),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/user.png"))),
                  )
                : Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 227, 237, 241),
                        ),
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                home.profile?.user?.picture ?? ''))),
                  ),
            20.verticalSpace,
            Text(
              home.profile?.user?.name ?? '',
              textAlign: TextAlign.center,
              style: FontPalette.black16500,
            ),
            20.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 65.w,
                  child: Text(
                    "Mobile",
                    style: FontPalette.black15500,
                  ),
                ),
                Text(
                  ":",
                  style: FontPalette.black15500,
                ),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    "${home.profile?.user?.mobile ?? ''}",
                    style: FontPalette.black15500,
                  ),
                )
              ],
            ),
            10.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 65.w,
                  child: Text(
                    "Email",
                    style: FontPalette.black15500,
                  ),
                ),
                Text(
                  ":",
                  style: FontPalette.black15500,
                ),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    "${home.profile?.user?.email ?? ''}",
                    style: FontPalette.black15500,
                  ),
                )
              ],
            ),
            10.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 65.w,
                  child: Text(
                    "Address",
                    style: FontPalette.black15500,
                  ),
                ),
                Text(
                  ":",
                  style: FontPalette.black15500,
                ),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    "${home.profile?.user?.address ?? ''}",
                    style: FontPalette.black15500,
                  ),
                )
              ],
            ),
          ],
        ).horizontalPadding(20.w),
      ),
    );
  }
}
