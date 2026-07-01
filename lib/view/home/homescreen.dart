import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/app_config.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/services/network/api_request.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_button.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_container.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:elaveoironing_vendor/view/authscreens/loginpage.dart';
import 'package:elaveoironing_vendor/view/home/collection_report.dart';
import 'package:elaveoironing_vendor/view/home/completed.dart';
import 'package:elaveoironing_vendor/view/home/pending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/view/home/profile.dart';
import 'package:elaveoironing_vendor/view/home/progress.dart';
import 'package:elaveoironing_vendor/viewmodel.dart/homeservice.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  draw() {
    Drawer(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    final home = context.read<HomeProvider>();
    bool serviceEnabled;
    LocationPermission permission;
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return early
      return;
    }
    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return early
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return;
    }
    // Fetch the current position
    await home.updateposition();
  }

  @override
  Widget build(BuildContext context) {
    print("token=${AppConfig.authToken}");
    final homeservices = GetIt.instance<HomeServices>();
    return Consumer<HomeProvider>(
      builder: (context, homeprovider, child) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.h,
          // systemOverlayStyle:
          //     SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(2, 94, 57, 1)),
        ),
        // backgroundColor: Colors.white,
        bottomSheet: homeprovider.version?.currentVersion?.androidVersion !=
                AppConfig.version
            ? BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.w),
                            topRight: Radius.circular(50.w)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20.r,
                              offset: const Offset(0, 5))
                        ],
                      ),
                      height: 300.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 25.h,
                                      width: 25.w,
                                      child: SvgPicture.asset(
                                        "assets/google_play.svg",
                                        fit: BoxFit.contain,
                                      )),
                                  8.horizontalSpace,
                                  Text("Google Play",
                                      style: FontPalette.grey15500),
                                ],
                              ),
                              25.verticalSpace,
                              Row(
                                children: [
                                  Text("Update available",
                                      style: FontPalette.black17500),
                                ],
                              ),
                              15.verticalSpace,
                              Row(
                                children: [
                                  Text(
                                      "To use this app, download the latest version",
                                      style: FontPalette.grey11400),
                                ],
                              ),
                              10.verticalSpace,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 55.w,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10.r,
                                            color: const Color.fromARGB(
                                                255, 233, 232, 232))
                                      ],
                                      image: const DecorationImage(
                                          image: AssetImage("assets/logo.jpg"),
                                          fit: BoxFit.cover),
                                      // color: HexColor("#791AB1"),
                                    ),
                                  ),
                                  15.horizontalSpace,
                                  Column(
                                    children: [
                                      Text("Partner EL",
                                          style: FontPalette.black16500),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(
                                fontStyle: FontPalette.white14400,
                                onTap: () async {
                                  await launchUrl(Uri.parse(
                                      "https://play.google.com/store/apps/details?id=com.shopkeeper_laundry.app"));
                                },
                                width: 130.w,
                                text: "Update",
                              ),
                            ],
                          )
                        ],
                      )
                          .horizontalPadding(25.w)
                          .verticalPadding(20.h)
                          .topPadding(20.h));
                },
              )
            : null,
        drawerEnableOpenDragGesture:
            homeprovider.version?.currentVersion?.androidVersion ==
                    AppConfig.version
                ? true
                : false,
        drawer: IgnorePointer(
          ignoring: homeprovider.version?.currentVersion?.androidVersion ==
                  AppConfig.version
              ? false
              : true,
          child: Drawer(
              backgroundColor: Colors.white,
              elevation: 0,
              width: MediaQuery.of(context).size.width - 40.w,
              child: Consumer<HomeProvider>(
                builder: (context, homeprovider, child) => Stack(children: [
                  IgnorePointer(
                    ignoring:
                        homeprovider.locationLoaderState == LoaderState.loading
                            ? true
                            : false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            50.verticalSpace,
                            Row(
                              children: [
                                homeprovider.profile?.user?.picture == null
                                    ? Container(
                                        width: 92.w,
                                        height: 92.h,
                                        decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                238, 243, 242, 1),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/user.png"))),
                                      )
                                    : Container(
                                        width: 100.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 227, 237, 241),
                                            ),
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(homeprovider
                                                        .profile
                                                        ?.user
                                                        ?.picture ??
                                                    ''))),
                                      ),
                                // Image.asset("assets/Ellipse 128.png"),
                                13.horizontalSpace,
                                Column(
                                  children: [
                                    Text(
                                      "Laundry",
                                      style: GoogleFonts.inter(
                                          //  color: Colors.black,
                                          color: Color.fromRGBO(54, 48, 48, 1),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Expert",
                                      style: GoogleFonts.inter(
                                          //  color: Colors.black,
                                          color: Color.fromRGBO(54, 48, 48, 1),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            15.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${AppConfig.name}",
                                    style: GoogleFonts.inter(
                                        color: HexColor("#008D6C"),
                                        // color: Color.fromARGB(255, 32, 180, 249),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ).horizontalPadding(10.w),
                            40.verticalSpace,
                            InkWell(
                              splashColor: Colors.white,
                              highlightColor: Colors.white,
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Profilescreen(),
                              )),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Profile",
                                      style: FontPalette.black15500,
                                    ),
                                    Image.asset("assets/Group 3.png")
                                  ],
                                ).horizontalPadding(15.w),
                              ),
                            ),
                            15.verticalSpace,
                            InkWell(
                              splashColor: Colors.white,
                              highlightColor: Colors.white,
                              onTap: () async {
                                await getCurrentLocation();
                                await homeservices
                                    .locationupdate(
                                        latitude: homeprovider
                                            .currentPosition?.latitude,
                                        longitude: homeprovider
                                            .currentPosition?.longitude)
                                    .catchError((error) {
                                  return error;
                                });
                                homeprovider.update();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Update Location",
                                      style: FontPalette.black15500,
                                    ),
                                    Image.asset("assets/location.png")
                                  ],
                                ).horizontalPadding(15.w),
                              ),
                            ),
                            15.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Notification",
                                    style: FontPalette.black15500,
                                  ),
                                  Image.asset("assets/Vector.png")
                                ],
                              ).horizontalPadding(15.w),
                            ),
                            15.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Get Support",
                                    style: FontPalette.black15500,
                                  ),
                                  Image.asset("assets/like-tag.png")
                                ],
                              ).horizontalPadding(15.w),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            logoutdialog(context: context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Logout",
                                style: FontPalette.black15600,
                              ),
                              // const Icon(
                              //   Icons.logout,
                              //   color: Colors.green,
                              // )
                            ],
                          ).horizontalPadding(15.w),
                        ),
                      ],
                    ).verticalPadding(30.h).horizontalPadding(20.w),
                  ),
                  homeprovider.locationLoaderState == LoaderState.loading
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color:
                                      const Color.fromARGB(255, 211, 210, 210)),
                              child:
                                  CircularProgressIndicator().allPadding(11.h)),
                        )
                      : SizedBox()
                ]),
              )),
        ),
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        body: IgnorePointer(
          ignoring: homeprovider.version?.currentVersion?.androidVersion ==
                  AppConfig.version
              ? false
              : true,
          child: Consumer<HomeProvider>(
            builder: (context, home, child) => SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(2, 94, 57, 1),
                        // color: Color.fromARGB(255, 25, 55, 70),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.r),
                            bottomRight: Radius.circular(32.r))),
                    child: Column(
                      children: [
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                scaffoldKey.currentState?.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 30.w,
                              ),
                            ),
                            Image.asset(
                              "assets/noti.png",
                              height: 23.h,
                            )
                          ],
                        ),
                        20.verticalSpace,
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Laundry",
                        //       style: GoogleFonts.aboreto(
                        //           color: Colors.white,
                        //           // color: Color.fromARGB(255, 32, 180, 249),
                        //           fontSize: 40.sp,
                        //           fontWeight: FontWeight.w700),
                        //       // style: FontPalette.green30700,
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Experts",
                        //       style: GoogleFonts.aboreto(
                        //           color: Colors.white,

                        //           //       color: Color.fromARGB(255, 32, 180, 249),
                        //           fontSize: 40.sp,
                        //           fontWeight: FontWeight.w700),
                        //       // style: FontPalette.green30700,
                        //     ),
                        //   ],
                        // ),
                        10.verticalSpace,
                        Consumer<HomeProvider>(
                            builder: (context, myNotifier, _) {
                          return Container(
                            height: 42.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26.r),
                                //  border: Border.all(color: Colors.white)
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppConfig.isactive == true
                                      ? "Active"
                                      : "Inactive",
                                  style: FontPalette.black15500,
                                ).leftPadding(20.w),
                                SizedBox(
                                    width: 45.w,
                                    height: 22.h,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Switch(
                                        activeTrackColor: HexColor("#02A278"),
                                        activeColor: Colors.white,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Colors.red,
                                        trackOutlineColor:
                                            WidgetStateProperty.all(
                                                Colors.transparent),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: AppConfig.isactive ?? false,
                                        onChanged: (value) async {
                                          opendialog(
                                              context: context, value: value);
                                        },
                                      ),
                                    )).rightPadding(10.w)
                              ],
                            ),
                          );
                        }),
                      ],
                    ).verticalPadding(25.h).horizontalPadding(20.h),
                  ),
                  Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Laundry",
                      //       style: TextStyle(
                      //           color: Color.fromARGB(255, 249, 122, 32),
                      //           fontSize: 30.sp,
                      //           fontWeight: FontWeight.w700),
                      //       // style: FontPalette.green30700,
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Experts",
                      //       style: TextStyle(
                      //           color: Color.fromARGB(255, 249, 122, 32),
                      //           fontSize: 30.sp,
                      //           fontWeight: FontWeight.w700),
                      //       // style: FontPalette.green30700,
                      //     ),
                      //   ],
                      // ),
                      // 25.verticalSpace,
                      //new ui
                      //  15.verticalSpace,
                      Row(
                        children: [Image.asset("assets/Laundry Experts.png")],
                      ),
                      15.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                              child: CustomContainer(
                            height: 170.h,
                            ontap: () {
                              print("pendinggg");
                              final model = context.read<HomeProvider>();
                              model.pending(status: 1);
                              print(
                                  "counttt=${model.pendingdata?.orders?.length}");
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoadPending(),
                              ));
                            },
                            bordercolor: Color.fromRGBO(145, 212, 197, 1),
                            width: 2,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(0, 83, 64, 1),
                                Color.fromRGBO(0, 185, 142, 1)
                              ],
                              // begin: Alignment.topRight,
                              // end: Alignment.bottomCenter
                            ),
                            child: Stack(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Divider(
                                    color: Color.fromARGB(255, 109, 179, 144),
                                  ),
                                  // Image.asset("assets/Line 54.png"),
                                  5.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Pending Orders",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        width: 42.w,
                                        height: 42.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Color.fromRGBO(5, 157, 66, 1)),
                                        child: Center(
                                          child: Text(
                                              home.countdata?.counts?.pending
                                                      .toString() ??
                                                  '0',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Colors.white,
                                                  // color: Color.fromARGB(255, 13, 80, 135),
                                                  fontWeight: FontWeight.w600)),
                                          //Text(count.toString(),
                                          // style: TextStyle(
                                          //     fontSize: 15.sp,
                                          //     color: Colors.white,
                                          //     // color: Color.fromARGB(255, 13, 80, 135),
                                          //     fontWeight: FontWeight.w600)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ).verticalPadding(10.h).horizontalPadding(5.w),
                              Positioned(
                                left: 16.w,
                                top: -15.h,
                                child: Image.asset(
                                  "assets/time DD 1.png",
                                  height: 100.h,
                                ),
                              )
                            ]),
                          )),
                          15.horizontalSpace,
                          Expanded(
                              child: CustomContainer(
                            height: 170.h,
                            ontap: () {
                              final model = context.read<HomeProvider>();
                              model.pending(status: 2);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoadProgress(),
                              ));
                            },
                            bordercolor: Color.fromRGBO(145, 212, 197, 1),
                            width: 2,
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(0, 83, 64, 1),
                                  Color.fromRGBO(0, 185, 142, 1),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topLeft),
                            child: Stack(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Divider(
                                    color: Color.fromARGB(255, 109, 179, 144),
                                  ),
                                  5.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Progress",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        width: 42.w,
                                        height: 42.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Color.fromRGBO(5, 157, 66, 1)),
                                        child: Center(
                                          child: Text(
                                              home.countdata?.counts?.inProgress
                                                      .toString() ??
                                                  '0',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Colors.white,
                                                  // color: Color.fromARGB(255, 13, 80, 135),
                                                  fontWeight: FontWeight.w600)),
                                          //Text(count.toString(),
                                          // style: TextStyle(
                                          //     fontSize: 15.sp,
                                          //     color: Colors.white,
                                          //     // color: Color.fromARGB(255, 13, 80, 135),
                                          //     fontWeight: FontWeight.w600)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ).verticalPadding(10.h).horizontalPadding(5.w),
                              Positioned(
                                left: 16.w,
                                top: -5.h,
                                child: Image.asset(
                                  "assets/time DD 5.png",
                                  height: 100.h,
                                ),
                              )
                            ]),
                            // Center(
                            //     child: Text(
                            //   "Progress",
                            //   style: TextStyle(
                            //       color: Colors.black,
                            //       fontSize: 18.sp,
                            //       fontWeight: FontWeight.w500),
                            // )),
                          )),
                        ],
                      ),
                      15.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                              child: CustomContainer(
                            height: 170.h,
                            ontap: () {
                              final model = context.read<HomeProvider>();
                              model.pending(status: 3);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoadCompleted(),
                              ));
                            },
                            bordercolor: Color.fromRGBO(145, 212, 197, 1),
                            width: 2,
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(0, 83, 64, 1),
                                  Color.fromRGBO(0, 185, 142, 1)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft),

                            // borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(28.r),
                            //     topRight: Radius.circular(28.r)),
                            // border: Border.all(
                            //   color: Colors.orange,
                            // ),
                            child: Stack(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Divider(
                                    color: Color.fromARGB(255, 109, 179, 144),
                                  ),
                                  5.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Completed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        width: 42.w,
                                        height: 42.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Color.fromRGBO(5, 157, 66, 1)),
                                        child: Center(
                                          child: Text(
                                              home.countdata?.counts?.completed
                                                      .toString() ??
                                                  '0',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Colors.white,
                                                  // color: Color.fromARGB(255, 13, 80, 135),
                                                  fontWeight: FontWeight.w600)),
                                          //Text(count.toString(),
                                          // style: TextStyle(
                                          //     fontSize: 15.sp,
                                          //     color: Colors.white,
                                          //     // color: Color.fromARGB(255, 13, 80, 135),
                                          //     fontWeight: FontWeight.w600)),
                                        ),
                                      )
                                    ],
                                  ),
                                  //10.verticalSpace
                                ],
                              ).verticalPadding(10.h).horizontalPadding(5.w),
                              Positioned(
                                left: 16.w,
                                top: -5.h,
                                child: Image.asset(
                                  "assets/time DD 2.png",
                                  height: 100.h,
                                ),
                              )
                            ]),
                            // Center(
                            //     child: Text(
                            //   "Completed",
                            //   style: TextStyle(
                            //       color: Colors.black,
                            //       fontSize: 18.sp,
                            //       fontWeight: FontWeight.w500),
                            // )),
                          )),
                          15.horizontalSpace,
                          Expanded(
                              child: CustomContainer(
                            height: 170.h,
                            ontap: () {
                              final model = context.read<HomeProvider>();
                              model.report(fromdata: '', todate: '');
                              model.updatefromdate(DateTime.now());
                              model.updatetodate(DateTime.now());
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Loadreport(),
                              ));
                            },
                            // boxshadow: [
                            //   BoxShadow(
                            //     color: Color.fromARGB(
                            //         255, 173, 171, 156), // Shadow color
                            //     spreadRadius: 2, // How much the shadow spreads
                            //     blurRadius: 1, // How soft the shadow is
                            //     offset: const Offset(5, 5), // Offset of the shadow
                            //   ),
                            // ],
                            bordercolor: Color.fromRGBO(145, 212, 197, 1),
                            width: 2,
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(0, 83, 64, 1),
                                  Color.fromRGBO(0, 185, 142, 1)
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomCenter),
                            child: Stack(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Divider(
                                    color: Color.fromARGB(255, 109, 179, 144),
                                  ),
                                  5.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Collection Report",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ).horizontalPadding(20.w),
                                      ),
                                      // Container(
                                      //   width: 42.w,
                                      //   height: 42.h,
                                      //   decoration: BoxDecoration(
                                      //       shape: BoxShape.circle,
                                      //       color:
                                      //           Color.fromRGBO(5, 157, 66, 1)),
                                      //   child: Center(
                                      //     child: Text(
                                      //         home.countdata?.counts?.completed
                                      //                 .toString() ??
                                      //             '0',
                                      //         style: TextStyle(
                                      //             fontSize: 11.sp,
                                      //             color: Colors.white,
                                      //             // color: Color.fromARGB(255, 13, 80, 135),
                                      //             fontWeight: FontWeight.w600)),
                                      //     //Text(count.toString(),
                                      //     // style: TextStyle(
                                      //     //     fontSize: 15.sp,
                                      //     //     color: Colors.white,
                                      //     //     // color: Color.fromARGB(255, 13, 80, 135),
                                      //     //     fontWeight: FontWeight.w600)),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ],
                              ).verticalPadding(10.h).horizontalPadding(5.w),
                              Positioned(
                                left: 16.w,
                                top: -5.h,
                                child: Image.asset(
                                  "assets/time DD 3.png",
                                  height: 100.h,
                                ),
                              )
                            ]),
                            // Center(
                            //     child: Text(
                            //   "Collection Report",
                            //   style: TextStyle(
                            //       color: Colors.black,
                            //       fontSize: 17.sp,
                            //       fontWeight: FontWeight.w500),
                            // )),
                          )),
                        ],
                      ),
                    ],
                  ).horizontalPadding(25.w).verticalPadding(30.h)
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  logoutdialog({
    BuildContext? context,
  }) async {
    final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
    final homeservices = GetIt.instance<HomeServices>();
    await showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          scrollable: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Are you sure you want to logout ?',
                  style: FontPalette.black13400,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text(
                      'No',
                      style: TextStyle(color: HexColor("#577D86")),
                    ),
                    onPressed: () async {
                      Navigator.of(context)
                          .pop(false); // Return true on confirm
                    },
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, child) => ElevatedButton(
                      child: isLoading.value == true
                          ? CircularProgressIndicator(
                              color: HexColor("#577D86"))
                          : Text(
                              'Yes',
                              style: TextStyle(color: HexColor("#577D86")),
                            ),
                      onPressed: () async {
                        isLoading.value = true;
                        final res =
                            await homeservices.logout().catchError((error) {
                          return false;
                        });
                        if (res ?? false) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen()),
                              (Route<dynamic> route) => false);
                          sharedPrefs.clearToken();
                          isLoading.value = false;
                        } else {
                          isLoading.value = false;
                        }
                        isLoading.value = false;
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  opendialog({BuildContext? context, bool? value}) async {
    final services = GetIt.instance<HomeServices>();
    final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

    await showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          scrollable: true,
          title: Text(
            'Are you sure you want to proceed with ${value == true ? "activate" : "inactivate"}?',
            style: FontPalette.black13400,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: TextStyle(color: HexColor("#577D86")),
              ),
              onPressed: () async {
                Navigator.of(context).pop(false); // Return true on confirm
              },
            ),
            Consumer<HomeProvider>(builder: (context, myNotifier, _) {
              return ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, values, child) => ElevatedButton(
                  child: isLoading.value == true
                      ? CircularProgressIndicator(
                          color: HexColor("#577D86"),
                        )
                      : Text(
                          'Yes',
                          style: TextStyle(color: HexColor("#577D86")),
                        ),
                  onPressed: () async {
                    isLoading.value = true;
                    myNotifier.updateSwitchValue(value!);
                    final res = await services
                        .updateactive(status: value == true ? 1 : 0)
                        .catchError((error) {
                      return error;
                    });
                    if (res ?? false) {
                      Navigator.of(context).pop(false);
                      isLoading.value = false;
                    } else {
                      isLoading.value = false;
                      myNotifier.updateSwitchValue(!value);
                    }
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
