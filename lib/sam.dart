import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';

class Home1screen extends StatefulWidget {
  const Home1screen({super.key});

  @override
  State<Home1screen> createState() => _Home1screenState();
}

class _Home1screenState extends State<Home1screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            40.verticalSpace,
            Row(
              children: [
                Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 68, 56),

                      // color: const Color.fromARGB(255, 156, 247, 58),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.r),
                          bottomRight: Radius.circular(20.r))),
                  child: const Icon(Icons.menu),
                ),
                220.horizontalSpace,
                Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 21, 95),

                      // color: const Color.fromARGB(255, 244, 241, 55),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          bottomLeft: Radius.circular(20.r))),
                  child: const Icon(Icons.notifications),
                ),
              ],
            ),
            50.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 86, 84, 71)
                            .withOpacity(0.3), // Shadow color
                        spreadRadius: 5, // How much the shadow spreads
                        blurRadius: 10, // How soft the shadow is
                        offset: const Offset(5, 5), // Offset of the shadow
                      ),
                    ],
                    color: const Color.fromARGB(255, 44, 43, 43),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(28.r),
                        topRight: Radius.circular(28.r)),
                    border: Border.all(
                      color: const Color.fromARGB(255, 244, 68, 56),
                    ),
                  ),
                  child: const Center(
                      child: Text(
                    "Home",
                    style: TextStyle(color: Color.fromARGB(255, 249, 248, 248)),
                  )),
                )),
                15.horizontalSpace,
                Expanded(
                    child: Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 86, 84, 71)
                            .withOpacity(0.3), // Shadow color
                        spreadRadius: 5, // How much the shadow spreads
                        blurRadius: 10, // How soft the shadow is
                        offset: const Offset(5, 5), // Offset of the shadow
                      ),
                    ],
                    color: const Color.fromARGB(255, 44, 43, 43),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(28.r),
                        topLeft: Radius.circular(28.r)),
                    border: Border.all(
                      color: const Color.fromARGB(255, 221, 21, 95),
                    ),
                  ),
                  child: const Center(
                      child: Text(
                    "Home",
                    style: TextStyle(color: Color.fromARGB(255, 250, 249, 248)),
                  )),
                )),
              ],
            ),
            15.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 86, 84, 71)
                            .withOpacity(0.3), // Shadow color
                        spreadRadius: 5, // How much the shadow spreads
                        blurRadius: 10, // How soft the shadow is
                        offset: const Offset(5, 5), // Offset of the shadow
                      ),
                    ],
                    color: const Color.fromARGB(255, 44, 43, 43),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(28.r),
                        topLeft: Radius.circular(28.r)),
                    border: Border.all(
                      color: const Color.fromARGB(255, 221, 21, 95),
                    ),
                  ),
                  child: const Center(
                      child: Text(
                    "Home",
                    style: TextStyle(color: Color.fromARGB(255, 247, 245, 244)),
                  )),
                )),
                15.horizontalSpace,
                Expanded(
                    child: Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 44, 43, 43),
                    border: Border.all(
                      color: const Color.fromARGB(255, 244, 68, 56),
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(28.r),
                        topRight: Radius.circular(28.r)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 86, 84, 71)
                            .withOpacity(0.3), // Shadow color
                        spreadRadius: 5, // How much the shadow spreads
                        blurRadius: 10, // How soft the shadow is
                        offset: const Offset(5, 5), // Offset of the shadow
                      ),
                    ],
                  ),
                  child: const Center(
                      child: Text(
                    "Home",
                    style: TextStyle(color: Color.fromARGB(255, 244, 243, 242)),
                  )),
                )),
              ],
            ),
            100.verticalSpace,
            Container(
              width: 334.w,
              height: 48.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 244, 68, 56),
                  Color.fromARGB(255, 221, 21, 95)

                  // Color.fromARGB(255, 156, 247, 58),
                  // Color.fromARGB(255, 244, 241, 55)
                ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r)),
                // color: Color.fromARGB(255, 221, 21, 95)
              ),

              // border:
              //     Border.all(color: const Color.fromARGB(255, 25, 117, 193))
              // color: const Color.fromARGB(255, 243, 69, 5)),
              child: Center(
                  child: Text(
                "Continue",
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 246, 243, 243)),
              )),
            ),
          ],
        ).horizontalPadding(20.w),
      ),
    );
  }
}
