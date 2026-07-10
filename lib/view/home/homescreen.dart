// import 'package:flutter_svg/svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:elaveoironing_vendor/homeprovider.dart';
// import 'package:elaveoironing_vendor/res/app_config.dart';
// import 'package:elaveoironing_vendor/res/color_pallete.dart';
// import 'package:elaveoironing_vendor/res/font_palette.dart';
// import 'package:elaveoironing_vendor/services/network/api_request.dart';
// import 'package:elaveoironing_vendor/utils/common_widgets/custom_button.dart';
// import 'package:elaveoironing_vendor/utils/common_widgets/custom_container.dart';
// import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
// import 'package:elaveoironing_vendor/view/authscreens/loginpage.dart';
// import 'package:elaveoironing_vendor/view/home/collection_report.dart';
// import 'package:elaveoironing_vendor/view/home/completed.dart';
// import 'package:elaveoironing_vendor/view/home/pending.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:elaveoironing_vendor/view/home/profile.dart';
// import 'package:elaveoironing_vendor/view/home/progress.dart';
// import 'package:elaveoironing_vendor/viewmodel.dart/homeservice.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   draw() {
//     Drawer(
//       backgroundColor: Color.fromARGB(255, 255, 255, 255),
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//       ),
//     );
//   }

//   Future<void> getCurrentLocation() async {
//     final home = context.read<HomeProvider>();
//     bool serviceEnabled;
//     LocationPermission permission;
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, return early
//       return;
//     }
//     // Check for location permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, return early
//         return;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are permanently denied
//       return;
//     }
//     // Fetch the current position
//     await home.updateposition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("token=${AppConfig.authToken}");
//     final homeservices = GetIt.instance<HomeServices>();
//     return Consumer<HomeProvider>(
//       builder: (context, homeprovider, child) => Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 0.h,
//           // systemOverlayStyle:
//           //     SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(2, 94, 57, 1)),
//         ),
//         // backgroundColor: Colors.white,
//         bottomSheet: homeprovider.version?.currentVersion?.androidVersion !=
//                 AppConfig.version
//             ? BottomSheet(
//                 onClosing: () {},
//                 builder: (BuildContext context) {
//                   return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(50.w),
//                             topRight: Radius.circular(50.w)),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.grey,
//                               blurRadius: 20.r,
//                               offset: const Offset(0, 5))
//                         ],
//                       ),
//                       height: 300.h,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   SizedBox(
//                                       height: 25.h,
//                                       width: 25.w,
//                                       child: SvgPicture.asset(
//                                         "assets/google_play.svg",
//                                         fit: BoxFit.contain,
//                                       )),
//                                   8.horizontalSpace,
//                                   Text("Google Play",
//                                       style: FontPalette.grey15500),
//                                 ],
//                               ),
//                               25.verticalSpace,
//                               Row(
//                                 children: [
//                                   Text("Update available",
//                                       style: FontPalette.black17500),
//                                 ],
//                               ),
//                               15.verticalSpace,
//                               Row(
//                                 children: [
//                                   Text(
//                                       "To use this app, download the latest version",
//                                       style: FontPalette.grey11400),
//                                 ],
//                               ),
//                               10.verticalSpace,
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     height: 50.h,
//                                     width: 55.w,
//                                     decoration: BoxDecoration(
//                                       boxShadow: [
//                                         BoxShadow(
//                                             blurRadius: 10.r,
//                                             color: const Color.fromARGB(
//                                                 255, 233, 232, 232))
//                                       ],
//                                       image: const DecorationImage(
//                                           image: AssetImage("assets/logo.jpg"),
//                                           fit: BoxFit.cover),
//                                       // color: HexColor("#791AB1"),
//                                     ),
//                                   ),
//                                   15.horizontalSpace,
//                                   Column(
//                                     children: [
//                                       Text("Partner EL",
//                                           style: FontPalette.black16500),
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               CustomButton(
//                                 fontStyle: FontPalette.white14400,
//                                 onTap: () async {
//                                   await launchUrl(Uri.parse(
//                                       "https://play.google.com/store/apps/details?id=com.shopkeeper_laundry.app"));
//                                 },
//                                 width: 130.w,
//                                 text: "Update",
//                               ),
//                             ],
//                           )
//                         ],
//                       )
//                           .horizontalPadding(25.w)
//                           .verticalPadding(20.h)
//                           .topPadding(20.h));
//                 },
//               )
//             : null,
//         drawerEnableOpenDragGesture:
//             homeprovider.version?.currentVersion?.androidVersion ==
//                     AppConfig.version
//                 ? true
//                 : false,
//         drawer: IgnorePointer(
//           ignoring: homeprovider.version?.currentVersion?.androidVersion ==
//                   AppConfig.version
//               ? false
//               : true,
//           child: Drawer(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               width: MediaQuery.of(context).size.width - 40.w,
//               child: Consumer<HomeProvider>(
//                 builder: (context, homeprovider, child) => Stack(children: [
//                   IgnorePointer(
//                     ignoring:
//                         homeprovider.locationLoaderState == LoaderState.loading
//                             ? true
//                             : false,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             50.verticalSpace,
//                             Row(
//                               children: [
//                                 homeprovider.profile?.user?.picture == null
//                                     ? Container(
//                                         width: 92.w,
//                                         height: 92.h,
//                                         decoration: const BoxDecoration(
//                                             color: Color.fromRGBO(
//                                                 238, 243, 242, 1),
//                                             shape: BoxShape.circle,
//                                             image: DecorationImage(
//                                                 image: AssetImage(
//                                                     "assets/user.png"))),
//                                       )
//                                     : Container(
//                                         width: 100.w,
//                                         height: 100.h,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                               color: const Color.fromARGB(
//                                                   255, 227, 237, 241),
//                                             ),
//                                             color: Colors.white,
//                                             shape: BoxShape.circle,
//                                             image: DecorationImage(
//                                                 fit: BoxFit.cover,
//                                                 image: NetworkImage(homeprovider
//                                                         .profile
//                                                         ?.user
//                                                         ?.picture ??
//                                                     ''))),
//                                       ),
//                                 // Image.asset("assets/Ellipse 128.png"),
//                                 13.horizontalSpace,
//                                 Column(
//                                   children: [
//                                     Text(
//                                       "Ironing",
//                                       style: GoogleFonts.inter(
//                                           color: AppColors.primaryDark,
//                                           fontSize: 24.sp,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                     Text(
//                                       "Expert",
//                                       style: GoogleFonts.inter(
//                                           color: AppColors.primaryDark,
//                                           fontSize: 24.sp,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             15.verticalSpace,
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     "${AppConfig.name}",
//                                     style: GoogleFonts.inter(
//                                         color: AppColors.primaryLight,
//                                         fontSize: 15.sp,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                               ],
//                             ).horizontalPadding(10.w),
//                             40.verticalSpace,
//                             InkWell(
//                               splashColor: Colors.white,
//                               highlightColor: Colors.white,
//                               onTap: () =>
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => const Profilescreen(),
//                               )),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 4.h),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Profile",
//                                       style: FontPalette.black15500,
//                                     ),
//                                     Image.asset("assets/Group 3.png")
//                                   ],
//                                 ).horizontalPadding(15.w),
//                               ),
//                             ),
//                             15.verticalSpace,
//                             InkWell(
//                               splashColor: Colors.white,
//                               highlightColor: Colors.white,
//                               onTap: () async {
//                                 await getCurrentLocation();
//                                 await homeservices
//                                     .locationupdate(
//                                         latitude: homeprovider
//                                             .currentPosition?.latitude,
//                                         longitude: homeprovider
//                                             .currentPosition?.longitude)
//                                     .catchError((error) {
//                                   return error;
//                                 });
//                                 homeprovider.update();
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 4.h),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Update Location",
//                                       style: FontPalette.black15500,
//                                     ),
//                                     Image.asset("assets/location.png")
//                                   ],
//                                 ).horizontalPadding(15.w),
//                               ),
//                             ),
//                             15.verticalSpace,
//                             Padding(
//                               padding: EdgeInsets.symmetric(vertical: 4.h),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Notification",
//                                     style: FontPalette.black15500,
//                                   ),
//                                   Image.asset("assets/Vector.png")
//                                 ],
//                               ).horizontalPadding(15.w),
//                             ),
//                             15.verticalSpace,
//                             Padding(
//                               padding: EdgeInsets.symmetric(vertical: 4.h),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Get Support",
//                                     style: FontPalette.black15500,
//                                   ),
//                                   Image.asset("assets/like-tag.png")
//                                 ],
//                               ).horizontalPadding(15.w),
//                             ),
//                           ],
//                         ),
//                         InkWell(
//                           onTap: () {
//                             logoutdialog(context: context);
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Logout",
//                                 style: FontPalette.black15600,
//                               ),
//                               // const Icon(
//                               //   Icons.logout,
//                               //   color: Colors.green,
//                               // )
//                             ],
//                           ).horizontalPadding(15.w),
//                         ),
//                       ],
//                     ).verticalPadding(30.h).horizontalPadding(20.w),
//                   ),
//                   homeprovider.locationLoaderState == LoaderState.loading
//                       ? Align(
//                           alignment: Alignment.center,
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10.r),
//                                   color:
//                                       const Color.fromARGB(255, 211, 210, 210)),
//                               child:
//                                   CircularProgressIndicator().allPadding(11.h)),
//                         )
//                       : SizedBox()
//                 ]),
//               )),
//         ),
//         resizeToAvoidBottomInset: false,
//         key: scaffoldKey,
//         body: IgnorePointer(
//           ignoring: homeprovider.version?.currentVersion?.androidVersion ==
//                   AppConfig.version
//               ? false
//               : true,
//           child: Consumer<HomeProvider>(
//             builder: (context, home, child) => SafeArea(
//                 child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         gradient: AppColors.primaryGradient,
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(32.r),
//                             bottomRight: Radius.circular(32.r))),
//                     child: Column(
//                       children: [
//                         20.verticalSpace,
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 scaffoldKey.currentState?.openDrawer();
//                               },
//                               child: Icon(
//                                 Icons.menu,
//                                 color: Colors.white,
//                                 size: 30.w,
//                               ),
//                             ),
//                             Image.asset(
//                               "assets/noti.png",
//                               height: 23.h,
//                             )
//                           ],
//                         ),
//                         20.verticalSpace,
//                         // Row(
//                         //   children: [
//                         //     Text(
//                         //       "Laundry",
//                         //       style: GoogleFonts.aboreto(
//                         //           color: Colors.white,
//                         //           // color: Color.fromARGB(255, 32, 180, 249),
//                         //           fontSize: 40.sp,
//                         //           fontWeight: FontWeight.w700),
//                         //       // style: FontPalette.green30700,
//                         //     ),
//                         //   ],
//                         // ),
//                         // Row(
//                         //   children: [
//                         //     Text(
//                         //       "Experts",
//                         //       style: GoogleFonts.aboreto(
//                         //           color: Colors.white,

//                         //           //       color: Color.fromARGB(255, 32, 180, 249),
//                         //           fontSize: 40.sp,
//                         //           fontWeight: FontWeight.w700),
//                         //       // style: FontPalette.green30700,
//                         //     ),
//                         //   ],
//                         // ),
//                         10.verticalSpace,
//                         Consumer<HomeProvider>(
//                             builder: (context, myNotifier, _) {
//                           return Container(
//                             height: 42.h,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(26.r),
//                                 //  border: Border.all(color: Colors.white)
//                                 color: Colors.white),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   AppConfig.isactive == true
//                                       ? "Active"
//                                       : "Inactive",
//                                   style: FontPalette.black15500,
//                                 ).leftPadding(20.w),
//                                 SizedBox(
//                                     width: 45.w,
//                                     height: 22.h,
//                                     child: FittedBox(
//                                       fit: BoxFit.fill,
//                                       child: Switch(
//                                         activeTrackColor:
//                                             AppColors.primaryLight,
//                                         activeColor: Colors.white,
//                                         inactiveThumbColor: Colors.white,
//                                         inactiveTrackColor: Colors.red,
//                                         trackOutlineColor:
//                                             WidgetStateProperty.all(
//                                                 Colors.transparent),
//                                         materialTapTargetSize:
//                                             MaterialTapTargetSize.shrinkWrap,
//                                         value: AppConfig.isactive ?? false,
//                                         onChanged: (value) async {
//                                           opendialog(
//                                               context: context, value: value);
//                                         },
//                                       ),
//                                     )).rightPadding(10.w)
//                               ],
//                             ),
//                           );
//                         }),
//                       ],
//                     ).verticalPadding(25.h).horizontalPadding(20.h),
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "Ironing",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 249, 122, 32),
//                                 fontSize: 30.sp,
//                                 fontWeight: FontWeight.w700),
//                             // style: FontPalette.green30700,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "Experts",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 249, 122, 32),
//                                 fontSize: 30.sp,
//                                 fontWeight: FontWeight.w700),
//                             // style: FontPalette.green30700,
//                           ),
//                         ],
//                       ),
//                       // 25.verticalSpace,
//                       //new ui
//                       //  15.verticalSpace,
//                       // Row(
//                       //   children: [Image.asset("assets/Laundry Experts.png")],
//                       // ),
//                       15.verticalSpace,
//                       Row(
//                         children: [
//                           Expanded(
//                               child: CustomContainer(
//                             height: 170.h,
//                             ontap: () {
//                               print("pendinggg");
//                               final model = context.read<HomeProvider>();
//                               model.pending(status: 1);
//                               print(
//                                   "counttt=${model.pendingdata?.orders?.length}");
//                               Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => const LoadPending(),
//                               ));
//                             },
//                             bordercolor:
//                                 AppColors.primaryLight.withValues(alpha: 0.5),
//                             width: 2,
//                             gradient: AppColors.primaryGradient,
//                             child: Stack(children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Divider(
//                                     color: Colors.white.withValues(alpha: 0.3),
//                                   ),
//                                   // Image.asset("assets/Line 54.png"),
//                                   5.verticalSpace,
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           "Pending Orders",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                       Container(
//                                         width: 42.w,
//                                         height: 42.h,
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: AppColors.primaryDark),
//                                         child: Center(
//                                           child: Text(
//                                               home.countdata?.counts?.pending
//                                                       .toString() ??
//                                                   '0',
//                                               style: TextStyle(
//                                                   fontSize: 11.sp,
//                                                   color: Colors.white,
//                                                   // color: Color.fromARGB(255, 13, 80, 135),
//                                                   fontWeight: FontWeight.w600)),
//                                           //Text(count.toString(),
//                                           // style: TextStyle(
//                                           //     fontSize: 15.sp,
//                                           //     color: Colors.white,
//                                           //     // color: Color.fromARGB(255, 13, 80, 135),
//                                           //     fontWeight: FontWeight.w600)),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ).verticalPadding(10.h).horizontalPadding(5.w),
//                               Positioned(
//                                 left: 16.w,
//                                 top: -15.h,
//                                 child: Image.asset(
//                                   "assets/time DD 1.png",
//                                   height: 100.h,
//                                 ),
//                               )
//                             ]),
//                           )),
//                           15.horizontalSpace,
//                           Expanded(
//                               child: CustomContainer(
//                             height: 170.h,
//                             ontap: () {
//                               final model = context.read<HomeProvider>();
//                               model.pending(status: 2);
//                               Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => const LoadProgress(),
//                               ));
//                             },
//                             bordercolor:
//                                 AppColors.primaryLight.withValues(alpha: 0.5),
//                             width: 2,
//                             gradient: AppColors.primaryGradient,
//                             child: Stack(children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Divider(
//                                     color: Colors.white.withValues(alpha: 0.3),
//                                   ),
//                                   5.verticalSpace,
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           "Progress",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                       Container(
//                                         width: 42.w,
//                                         height: 42.h,
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: AppColors.primaryDark),
//                                         child: Center(
//                                           child: Text(
//                                               home.countdata?.counts?.inProgress
//                                                       .toString() ??
//                                                   '0',
//                                               style: TextStyle(
//                                                   fontSize: 11.sp,
//                                                   color: Colors.white,
//                                                   // color: Color.fromARGB(255, 13, 80, 135),
//                                                   fontWeight: FontWeight.w600)),
//                                           //Text(count.toString(),
//                                           // style: TextStyle(
//                                           //     fontSize: 15.sp,
//                                           //     color: Colors.white,
//                                           //     // color: Color.fromARGB(255, 13, 80, 135),
//                                           //     fontWeight: FontWeight.w600)),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ).verticalPadding(10.h).horizontalPadding(5.w),
//                               Positioned(
//                                 left: 16.w,
//                                 top: -5.h,
//                                 child: Image.asset(
//                                   "assets/time DD 5.png",
//                                   height: 100.h,
//                                 ),
//                               )
//                             ]),
//                             // Center(
//                             //     child: Text(
//                             //   "Progress",
//                             //   style: TextStyle(
//                             //       color: Colors.black,
//                             //       fontSize: 18.sp,
//                             //       fontWeight: FontWeight.w500),
//                             // )),
//                           )),
//                         ],
//                       ),
//                       15.verticalSpace,
//                       Row(
//                         children: [
//                           Expanded(
//                               child: CustomContainer(
//                             height: 170.h,
//                             ontap: () {
//                               final model = context.read<HomeProvider>();
//                               model.pending(status: 3);
//                               Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => const LoadCompleted(),
//                               ));
//                             },
//                             bordercolor:
//                                 AppColors.primaryLight.withValues(alpha: 0.5),
//                             width: 2,
//                             gradient: AppColors.primaryGradient,

//                             // borderRadius: BorderRadius.only(
//                             //     bottomLeft: Radius.circular(28.r),
//                             //     topRight: Radius.circular(28.r)),
//                             // border: Border.all(
//                             //   color: Colors.orange,
//                             // ),
//                             child: Stack(children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Divider(
//                                     color: Colors.white.withValues(alpha: 0.3),
//                                   ),
//                                   5.verticalSpace,
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           "Completed",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                       Container(
//                                         width: 42.w,
//                                         height: 42.h,
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: AppColors.primaryDark),
//                                         child: Center(
//                                           child: Text(
//                                               home.countdata?.counts?.completed
//                                                       .toString() ??
//                                                   '0',
//                                               style: TextStyle(
//                                                   fontSize: 11.sp,
//                                                   color: Colors.white,
//                                                   // color: Color.fromARGB(255, 13, 80, 135),
//                                                   fontWeight: FontWeight.w600)),
//                                           //Text(count.toString(),
//                                           // style: TextStyle(
//                                           //     fontSize: 15.sp,
//                                           //     color: Colors.white,
//                                           //     // color: Color.fromARGB(255, 13, 80, 135),
//                                           //     fontWeight: FontWeight.w600)),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   //10.verticalSpace
//                                 ],
//                               ).verticalPadding(10.h).horizontalPadding(5.w),
//                               Positioned(
//                                 left: 16.w,
//                                 top: -5.h,
//                                 child: Image.asset(
//                                   "assets/time DD 2.png",
//                                   height: 100.h,
//                                 ),
//                               )
//                             ]),
//                             // Center(
//                             //     child: Text(
//                             //   "Completed",
//                             //   style: TextStyle(
//                             //       color: Colors.black,
//                             //       fontSize: 18.sp,
//                             //       fontWeight: FontWeight.w500),
//                             // )),
//                           )),
//                           15.horizontalSpace,
//                           Expanded(
//                               child: CustomContainer(
//                             height: 170.h,
//                             ontap: () {
//                               final model = context.read<HomeProvider>();
//                               model.report(fromdata: '', todate: '');
//                               model.updatefromdate(DateTime.now());
//                               model.updatetodate(DateTime.now());
//                               Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => const Loadreport(),
//                               ));
//                             },
//                             // boxshadow: [
//                             //   BoxShadow(
//                             //     color: Color.fromARGB(
//                             //         255, 173, 171, 156), // Shadow color
//                             //     spreadRadius: 2, // How much the shadow spreads
//                             //     blurRadius: 1, // How soft the shadow is
//                             //     offset: const Offset(5, 5), // Offset of the shadow
//                             //   ),
//                             // ],
//                             bordercolor:
//                                 AppColors.primaryLight.withValues(alpha: 0.5),
//                             width: 2,
//                             gradient: AppColors.primaryGradient,
//                             child: Stack(children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Divider(
//                                     color: Colors.white.withValues(alpha: 0.3),
//                                   ),
//                                   5.verticalSpace,
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           textAlign: TextAlign.center,
//                                           "Collection Report",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w500),
//                                         ).horizontalPadding(20.w),
//                                       ),
//                                       // Container(
//                                       //   width: 42.w,
//                                       //   height: 42.h,
//                                       //   decoration: BoxDecoration(
//                                       //       shape: BoxShape.circle,
//                                       //       color:
//                                       //           Color.fromRGBO(5, 157, 66, 1)),
//                                       //   child: Center(
//                                       //     child: Text(
//                                       //         home.countdata?.counts?.completed
//                                       //                 .toString() ??
//                                       //             '0',
//                                       //         style: TextStyle(
//                                       //             fontSize: 11.sp,
//                                       //             color: Colors.white,
//                                       //             // color: Color.fromARGB(255, 13, 80, 135),
//                                       //             fontWeight: FontWeight.w600)),
//                                       //     //Text(count.toString(),
//                                       //     // style: TextStyle(
//                                       //     //     fontSize: 15.sp,
//                                       //     //     color: Colors.white,
//                                       //     //     // color: Color.fromARGB(255, 13, 80, 135),
//                                       //     //     fontWeight: FontWeight.w600)),
//                                       //   ),
//                                       // )
//                                     ],
//                                   ),
//                                 ],
//                               ).verticalPadding(10.h).horizontalPadding(5.w),
//                               Positioned(
//                                 left: 16.w,
//                                 top: -5.h,
//                                 child: Image.asset(
//                                   "assets/time DD 3.png",
//                                   height: 100.h,
//                                 ),
//                               )
//                             ]),
//                             // Center(
//                             //     child: Text(
//                             //   "Collection Report",
//                             //   style: TextStyle(
//                             //       color: Colors.black,
//                             //       fontSize: 17.sp,
//                             //       fontWeight: FontWeight.w500),
//                             // )),
//                           )),
//                         ],
//                       ),
//                     ],
//                   ).horizontalPadding(25.w).verticalPadding(30.h)
//                 ],
//               ),
//             )),
//           ),
//         ),
//       ),
//     );
//   }

//   logoutdialog({
//     BuildContext? context,
//   }) async {
//     final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
//     final homeservices = GetIt.instance<HomeServices>();
//     await showDialog(
//       barrierDismissible: false,
//       context: context!,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           scrollable: true,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Text(
//                   'Are you sure you want to logout ?',
//                   style: FontPalette.black13400,
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     child: Text(
//                       'No',
//                       style: TextStyle(color: AppColors.primaryDark),
//                     ),
//                     onPressed: () async {
//                       Navigator.of(context)
//                           .pop(false); // Return true on confirm
//                     },
//                   ),
//                 ),
//                 10.horizontalSpace,
//                 Expanded(
//                   child: ValueListenableBuilder(
//                     valueListenable: isLoading,
//                     builder: (context, value, child) => ElevatedButton(
//                       child: isLoading.value == true
//                           ? CircularProgressIndicator(
//                               color: AppColors.primaryDark)
//                           : Text(
//                               'Yes',
//                               style: TextStyle(color: AppColors.primaryDark),
//                             ),
//                       onPressed: () async {
//                         isLoading.value = true;
//                         final res =
//                             await homeservices.logout().catchError((error) {
//                           return false;
//                         });
//                         if (res ?? false) {
//                           Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) =>
//                                       const LoginScreen()),
//                               (Route<dynamic> route) => false);
//                           sharedPrefs.clearToken();
//                           isLoading.value = false;
//                         } else {
//                           isLoading.value = false;
//                         }
//                         isLoading.value = false;
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         );
//       },
//     );
//   }

//   opendialog({BuildContext? context, bool? value}) async {
//     final services = GetIt.instance<HomeServices>();
//     final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

//     await showDialog(
//       barrierDismissible: false,
//       context: context!,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           scrollable: true,
//           title: Text(
//             'Are you sure you want to proceed with ${value == true ? "activate" : "inactivate"}?',
//             style: FontPalette.black13400,
//             textAlign: TextAlign.center,
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'No',
//                 style: TextStyle(color: AppColors.primaryDark),
//               ),
//               onPressed: () async {
//                 Navigator.of(context).pop(false); // Return true on confirm
//               },
//             ),
//             Consumer<HomeProvider>(builder: (context, myNotifier, _) {
//               return ValueListenableBuilder(
//                 valueListenable: isLoading,
//                 builder: (context, values, child) => ElevatedButton(
//                   child: isLoading.value == true
//                       ? CircularProgressIndicator(
//                           color: AppColors.primaryDark,
//                         )
//                       : Text(
//                           'Yes',
//                           style: TextStyle(color: AppColors.primaryDark),
//                         ),
//                   onPressed: () async {
//                     isLoading.value = true;
//                     myNotifier.updateSwitchValue(value!);
//                     final res = await services
//                         .updateactive(status: value == true ? 1 : 0)
//                         .catchError((error) {
//                       return error;
//                     });
//                     if (res ?? false) {
//                       Navigator.of(context).pop(false);
//                       isLoading.value = false;
//                     } else {
//                       isLoading.value = false;
//                       myNotifier.updateSwitchValue(!value);
//                     }
//                   },
//                 ),
//               );
//             }),
//           ],
//         );
//       },
//     );
//   }
// }





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
  // Blue accent pair — matches the splash screen. If color_pallete.dart is
  // updated to the same values under AppColors, these locals become
  // redundant and can be swapped back to AppColors.* everywhere.
  static const Color _accent = Color(0xFF7692C2);
  static const Color _accentDeep = Color(0xFF1B365D);

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
        backgroundColor: const Color(0xFFF7F9FC),
        appBar: AppBar(
          toolbarHeight: 0.h,
        ),
        bottomSheet: homeprovider.version?.currentVersion?.androidVersion !=
                AppConfig.version
            ? BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.r),
                            topRight: Radius.circular(32.r)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: _accentDeep.withValues(alpha: 0.15),
                              blurRadius: 24.r,
                              offset: const Offset(0, -6))
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
                                  Container(
                                    padding: EdgeInsets.all(5.w),
                                    decoration: BoxDecoration(
                                      color: _accent.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: SizedBox(
                                        height: 18.h,
                                        width: 18.w,
                                        child: SvgPicture.asset(
                                          "assets/google_play.svg",
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                  8.horizontalSpace,
                                  Text("Google Play",
                                      style: FontPalette.grey15500),
                                ],
                              ),
                              22.verticalSpace,
                              Row(
                                children: [
                                  Text("Update available",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: _accentDeep)),
                                ],
                              ),
                              12.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        "To use this app, download the latest version",
                                        style: FontPalette.grey11400),
                                  ),
                                ],
                              ),
                              14.verticalSpace,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 55.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 12.r,
                                            color: _accentDeep.withValues(
                                                alpha: 0.12))
                                      ],
                                      image: const DecorationImage(
                                          image: AssetImage("assets/logo.jpg"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  15.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            40.verticalSpace,
                            Row(
                              children: [
                                homeprovider.profile?.user?.picture == null
                                    ? Container(
                                        width: 84.w,
                                        height: 84.h,
                                        decoration: BoxDecoration(
                                            color: _accent.withValues(
                                                alpha: 0.12),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: _accent.withValues(
                                                    alpha: 0.25)),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/user.png"))),
                                      )
                                    : Container(
                                        width: 90.w,
                                        height: 90.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: _accent.withValues(
                                                  alpha: 0.25),
                                              width: 2,
                                            ),
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(homeprovider
                                                        .profile
                                                        ?.user
                                                        ?.picture ??
                                                    ''),
                                                onError: (exception, stackTrace) {
                                                  debugPrint("Image error: $exception");
                                                })),
                                      ),
                                13.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ironing",
                                      style: GoogleFonts.inter(
                                          color: _accentDeep,
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Expert",
                                      style: GoogleFonts.inter(
                                          color: _accentDeep,
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            14.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${AppConfig.name}",
                                    style: GoogleFonts.inter(
                                        color: _accent,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ).horizontalPadding(10.w),
                            30.verticalSpace,
                            Divider(color: Colors.grey.shade200, height: 1),
                            30.verticalSpace,
                            InkWell(
                              splashColor: Colors.white,
                              highlightColor: Colors.white,
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Profilescreen(),
                              )),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
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
                            18.verticalSpace,
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
                                padding: EdgeInsets.symmetric(vertical: 6.h),
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
                            18.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.h),
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
                            18.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.h),
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
                        Column(
                          children: [
                            Divider(color: Colors.grey.shade200, height: 1),
                            18.verticalSpace,
                            InkWell(
                              onTap: () {
                                logoutdialog(context: context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Logout",
                                    style: FontPalette.black15600,
                                  ),
                                ],
                              ).horizontalPadding(15.w),
                            ),
                          ],
                        ),
                      ],
                    ).verticalPadding(30.h).horizontalPadding(20.w),
                  ),
                  homeprovider.locationLoaderState == LoaderState.loading
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.r),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: _accentDeep.withValues(
                                          alpha: 0.12),
                                      blurRadius: 20.r,
                                    )
                                  ]),
                              child: CircularProgressIndicator(
                                      color: _accent)
                                  .allPadding(14.h)),
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
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_accentDeep, _accent],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36.r),
                            bottomRight: Radius.circular(36.r)),
                        boxShadow: [
                          BoxShadow(
                            color: _accentDeep.withValues(alpha: 0.25),
                            blurRadius: 24.r,
                            offset: Offset(0, 10.h),
                          ),
                        ]),
                    child: Column(
                      children: [
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(20.r),
                              onTap: () {
                                scaffoldKey.currentState?.openDrawer();
                              },
                              child: Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 22.w,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                "assets/noti.png",
                                height: 18.h,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        22.verticalSpace,
                        Consumer<HomeProvider>(
                            builder: (context, myNotifier, _) {
                          return Container(
                            height: 44.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26.r),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: 10.r,
                                    offset: Offset(0, 4.h),
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8.w,
                                      height: 8.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppConfig.isactive == true
                                            ? const Color(0xFF34A853)
                                            : const Color(0xFFE24C4C),
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      AppConfig.isactive == true
                                          ? "Active"
                                          : "Inactive",
                                      style: FontPalette.black15500,
                                    ),
                                  ],
                                ).leftPadding(18.w),
                                SizedBox(
                                    width: 45.w,
                                    height: 22.h,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Switch(
                                        activeTrackColor: _accent,
                                        activeColor: Colors.white,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor:
                                            const Color(0xFFE24C4C),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      22.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "Ironing",
                            style: TextStyle(
                                color: _accentDeep,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          5.horizontalSpace,
                          Text(
                            "Experts",
                            style: TextStyle(
                                color: _accent,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Experts",
                      //       style: TextStyle(
                      //           color: _accent,
                      //           fontSize: 28.sp,
                      //           fontWeight: FontWeight.w700),
                      //     ),
                      //   ],
                      // ),
                      6.verticalSpace,
                      Text(
                        "Here's a quick look at your orders today",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                              child: _StatCard(
                            container: CustomContainer(
                              height: 170.h,
                              ontap: () {
                                final model = context.read<HomeProvider>();
                                model.pending(status: 1);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoadPending(),
                                ));
                              },
                              bordercolor: _accent.withValues(alpha: 0.35),
                              width: 2,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [_accentDeep, _accent],
                              ),
                              child: Stack(children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Divider(
                                      color:
                                          Colors.white.withValues(alpha: 0.25),
                                    ),
                                    6.verticalSpace,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "PENDING ORDERS",
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withValues(alpha: 0.9),
                                                fontSize: 11.sp,
                                                letterSpacing: 0.6,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.6),
                                                  width: 2)),
                                          child: Center(
                                            child: Text(
                                                home.countdata?.counts?.pending
                                                        .toString() ??
                                                    '0',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: _accentDeep,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ).verticalPadding(10.h).horizontalPadding(6.w),
                                Positioned(
                                  left: 16.w,
                                  top: -15.h,
                                  child: Image.asset(
                                    "assets/time DD 1.png",
                                    height: 100.h,
                                  ),
                                )
                              ]),
                            ),
                          )),
                          15.horizontalSpace,
                          Expanded(
                              child: _StatCard(
                            container: CustomContainer(
                              height: 170.h,
                              ontap: () {
                                final model = context.read<HomeProvider>();
                                model.pending(status: 2);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoadProgress(),
                                ));
                              },
                              bordercolor: _accent.withValues(alpha: 0.35),
                              width: 2,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [_accentDeep, _accent],
                              ),
                              child: Stack(children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Divider(
                                      color:
                                          Colors.white.withValues(alpha: 0.25),
                                    ),
                                    6.verticalSpace,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "PROGRESS",
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withValues(alpha: 0.9),
                                                fontSize: 11.sp,
                                                letterSpacing: 0.6,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.6),
                                                  width: 2)),
                                          child: Center(
                                            child: Text(
                                                home.countdata?.counts
                                                        ?.inProgress
                                                        .toString() ??
                                                    '0',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: _accentDeep,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ).verticalPadding(10.h).horizontalPadding(6.w),
                                Positioned(
                                  left: 16.w,
                                  top: -5.h,
                                  child: Image.asset(
                                    "assets/time DD 5.png",
                                    height: 100.h,
                                  ),
                                )
                              ]),
                            ),
                          )),
                        ],
                      ),
                      15.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                              child: _StatCard(
                            container: CustomContainer(
                              height: 170.h,
                              ontap: () {
                                final model = context.read<HomeProvider>();
                                model.pending(status: 3);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoadCompleted(),
                                ));
                              },
                              bordercolor: _accent.withValues(alpha: 0.35),
                              width: 2,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [_accentDeep, _accent],
                              ),
                              child: Stack(children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Divider(
                                      color:
                                          Colors.white.withValues(alpha: 0.25),
                                    ),
                                    6.verticalSpace,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "COMPLETED",
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withValues(alpha: 0.9),
                                                fontSize: 11.sp,
                                                letterSpacing: 0.6,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.6),
                                                  width: 2)),
                                          child: Center(
                                            child: Text(
                                                home.countdata?.counts
                                                        ?.completed
                                                        .toString() ??
                                                    '0',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: _accentDeep,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ).verticalPadding(10.h).horizontalPadding(6.w),
                                Positioned(
                                  left: 16.w,
                                  top: -5.h,
                                  child: Image.asset(
                                    "assets/time DD 2.png",
                                    height: 100.h,
                                  ),
                                )
                              ]),
                            ),
                          )),
                          15.horizontalSpace,
                          Expanded(
                              child: _StatCard(
                            container: CustomContainer(
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
                              bordercolor: _accent.withValues(alpha: 0.35),
                              width: 2,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [_accentDeep, _accent],
                              ),
                              child: Stack(children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Divider(
                                      color:
                                          Colors.white.withValues(alpha: 0.25),
                                    ),
                                    6.verticalSpace,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.left,
                                            "COLLECTION REPORT",
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withValues(alpha: 0.9),
                                                fontSize: 11.sp,
                                                letterSpacing: 0.6,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ).verticalPadding(10.h).horizontalPadding(6.w),
                                Positioned(
                                  left: 16.w,
                                  top: -5.h,
                                  child: Image.asset(
                                    "assets/time DD 3.png",
                                    height: 100.h,
                                  ),
                                )
                              ]),
                            ),
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Are you sure you want to logout ?',
                  style: FontPalette.black13400,
                  textAlign: TextAlign.center,
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: _accent.withValues(alpha: 0.4)),
                      ),
                    ),
                    child: Text(
                      'No',
                      style: TextStyle(color: _accentDeep),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accentDeep,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: isLoading.value == true
                          ? CircularProgressIndicator(
                              color: Colors.white)
                          : Text(
                              'Yes',
                              style: TextStyle(color: Colors.white),
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r)),
          title: Text(
            'Are you sure you want to proceed with ${value == true ? "activate" : "inactivate"}?',
            style: FontPalette.black13400,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: TextStyle(color: _accentDeep),
              ),
              onPressed: () async {
                Navigator.of(context).pop(false); // Return true on confirm
              },
            ),
            Consumer<HomeProvider>(builder: (context, myNotifier, _) {
              return ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, values, child) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accentDeep,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: isLoading.value == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Yes',
                          style: TextStyle(color: Colors.white),
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

/// Wraps a stat CustomContainer with an outer soft shadow so the cards
/// read as gently elevated tiles rather than flat blocks. Purely visual —
/// all tap handling stays inside the CustomContainer itself.
class _StatCard extends StatelessWidget {
  final Widget container;
  const _StatCard({required this.container});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B365D).withValues(alpha: 0.14),
            blurRadius: 16.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: container,
    );
  }
}