import 'package:intl/intl.dart';
import 'package:elaveoironing_vendor/datamodel/pending_datamodel.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/app_config.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_container.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/view/home/viewcloths.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadCompleted extends StatelessWidget {
  final int? index;
  final String? name;
  final String? id;
  final int? distance;
  final String? image;
  final double? lat;
  final double? long;
  const LoadCompleted(
      {Key? key,
      this.distance,
      this.lat,
      this.long,
      this.id,
      this.image,
      this.index,
      this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, LoaderState?>(
        selector: (context, provider) => provider.PendingLoaderState,
        builder: (context, value, child) {
          return (value == LoaderState.loading)
              ? Loadingompleted()
              : CompletedScreen();
        });
  }
}

class Loadingompleted extends StatefulWidget {
  const Loadingompleted({super.key});

  @override
  State<Loadingompleted> createState() => _LoadingompletedState();
}

class _LoadingompletedState extends State<Loadingompleted> {
  int i = 1;

  @override
  Widget build(BuildContext context) {
    // final data = context.read<WalletProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Completed",
          style: FontPalette.black23600,
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  // controller: controller,
                  physics: BouncingScrollPhysics(),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 90.h,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey)),
                    ).addShimmer().bottomPadding(20.h);
                  }),
              20.verticalSpace
            ],
          ).verticalPadding(20.h).horizontalPadding(25.w),
        );
      }),
    );
  }
}

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  precache() async {
    final home = context.read<HomeProvider>();
    int? len = home.pendingdata?.orders?.length;
    for (int i = 0; i < len!; i++) {
      int lenimage = home.pendingdata?.orders![i].orderImages?.length ?? 0;
      for (int n = 0; n < lenimage; n++) {
        await precacheImage(
            NetworkImage(
                "${home.pendingdata?.orders![i].orderImages![n].filePath}"),
            context,
            onError: (exception, stackTrace) {
              debugPrint("Failed to load image: $exception");
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        //centerTitle: true,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Completed",
          style: FontPalette.black23600,
        ),
      ),
      body: Consumer<HomeProvider>(
          builder: (context, homeprovider, child) => RefreshIndicator(
                color: Color.fromRGBO(0, 141, 108, 1),
                onRefresh: () async {
                  await homeprovider.pending(status: 3);
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      20.verticalSpace,
                      homeprovider.pendingdata?.orders?.length == 0
                          ? Column(
                              children: [
                                100.verticalSpace,
                                Center(child: Text("No Orders Found")),
                                100.verticalSpace
                              ],
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  homeprovider.pendingdata?.orders?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                precache();
                                print(homeprovider.pendingdata?.orders?.length);
                                return ContainerBooking(
                                  daccode: homeprovider
                                      .pendingdata?.orders![index].dacCode,
                                  number:
                                      "${homeprovider.pendingdata?.orders![index].orderNo}",
                                  len: homeprovider.pendingdata?.orders![index]
                                          .orderItems?.length ??
                                      0,
                                  mobile:
                                      "${homeprovider.pendingdata?.orders![index].customerPhone}",
                                  place:
                                      "${homeprovider.pendingdata?.orders![index].addressLine1}, ${homeprovider.pendingdata?.orders![index].addressLine2} - ${homeprovider.pendingdata?.orders![index].pincode}",
                                  date:
                                      "${homeprovider.pendingdata?.orders![index].dropoffDate}",
                                  deliveryboy:
                                      "${homeprovider.pendingdata?.orders![index].pickupDeliveryAgentName}",
                                  items: homeprovider
                                      .pendingdata?.orders![index].orderItems,
                                  name:
                                      "${homeprovider.pendingdata?.orders![index].customerName}",
                                  note: homeprovider
                                      .pendingdata?.orders![index].note,
                                  image: homeprovider
                                      .pendingdata?.orders![index].orderImages,
                                  time:
                                      "${homeprovider.pendingdata?.orders![index].dropoffTimeSlot?.startTime}-${homeprovider.pendingdata?.orders![index].dropoffTimeSlot?.endTime}",
                                ).horizontalPadding(20.w);
                              }),
                    ],
                  ),
                ),
              )),
    );
  }
}

class ContainerBooking extends StatelessWidget {
  final String? number;
  final String? time;
  final String? note;
  final String? date;
  final String? place;
  final List<OrderImages>? image;
  final String? name;
  final String? mobile;
  final int? daccode;
  final int? len;
  final List<OrderItems>? items;
  final String? deliveryboy;
  final String? address;
  final VoidCallback? onPressed;
  const ContainerBooking(
      {super.key,
      this.date,
      this.image,
      this.mobile,
      this.items,
      this.daccode,
      this.note,
      this.number,
      this.len,
      this.name,
      this.deliveryboy,
      this.time,
      this.place,
      this.onPressed,
      this.address});

  @override
  Widget build(BuildContext context) {
    String formattedDate = date == "null"
        ? "null"
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(date!));
    return CustomContainer(
      bordercolor: Color.fromRGBO(207, 209, 208, 1),
      borderradius: 20.r,
      boxcolor: "FFFFF",
      // bordercolor: 'CFD1D0',
      borderwidth: 2.sp,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Color.fromRGBO(0, 141, 108, 1)),
                        child: Row(
                          children: [
                            Text(
                              "DAC Code: $daccode",
                              style: FontPalette.white12500,
                            ).symmetricPadding(vertical: 10.h, horizontal: 10.w)
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "$number",
                              style: FontPalette.black12400,
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Text(
                      //       "Expected Delivery Time",
                      //       style: FontPalette.grey11400,
                      //     ),
                      //   ],
                      // ),
                      5.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$name",
                                  style: FontPalette.grey11400,
                                ),
                                Text(
                                  "$place",
                                  style: FontPalette.grey11400,
                                ),
                                10.verticalSpace,
                                Container(
                                  color: Colors.grey,
                                  height: 1.h,
                                ),
                                15.verticalSpace,
                                formattedDate == "null"
                                    ? SizedBox()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Expected",
                                                  style: FontPalette.grey12400,
                                                ),
                                                Text(
                                                  "Delivery Time",
                                                  style: FontPalette.grey12400,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            //    mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "$formattedDate",
                                                style: FontPalette.grey12400,
                                              ),
                                              Text(
                                                "$time",
                                                style: FontPalette.black12600,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                          // 5.horizontalSpace,
                          // Container(
                          //   // width: 85.w,
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Color.fromARGB(255, 86, 140, 206),
                          //         spreadRadius: 1,
                          //         blurRadius: 1,
                          //         offset: const Offset(4, 4), // X, Y offset
                          //       ),
                          //       BoxShadow(
                          //         color: Color.fromARGB(255, 78, 211, 189),
                          //         spreadRadius: 1,
                          //         blurRadius: 2,
                          //       ),
                          //     ],
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(13.r),
                          //     // color: HexColor("#C8ECF4")
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         textAlign: TextAlign.center,
                          //         "$formattedDate",
                          //         style: FontPalette.black10500,
                          //       ),
                          //       Text(
                          //         textAlign: TextAlign.center,
                          //         "$time",
                          //         style: FontPalette.black10500,
                          //       ),
                          //     ],
                          //   ).verticalPadding(5.h).horizontalPadding(10.w),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       deliveryboy == "null" || deliveryboy == null
          //           ? ''
          //           : "Pickup Delivery Agent: $deliveryboy",
          //       style: FontPalette.grey12400,
          //     )
          //   ],
          // ),
          10.verticalSpace,
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => makePhoneCall(mobile.toString()),
                  // onTap: () => makePhoneCall(customermobile.toString()),
                  child: Container(
                    height: 37.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#008D6C")),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone_in_talk_outlined,
                          color: Colors.black,
                        ),
                        3.horizontalSpace,
                        Text(
                          "Call Customer",
                          style: FontPalette.black10500,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 5.horizontalSpace,
              // Container(
              //   padding: EdgeInsets.all(6.w),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12.r),
              //       border: Border.all(color: Color.fromRGBO(0, 141, 108, 1))),
              //   child: Row(
              //     children: [
              //       Icon(Icons.comment),
              //       4.horizontalSpace,
              //       Text("Complaint")
              //     ],
              //   ),
              // )
            ],
          ),
          5.verticalSpace,
          // InkWell(
          //   onTap: () => makePhoneCall(mobile.toString()),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(12.r),
          //         border: Border.all(color: Color.fromRGBO(0, 141, 108, 1))),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 8.w),
          //       child: Row(
          //         children: [
          //           const Icon(
          //             Icons.phone_in_talk_rounded,
          //             color: Colors.black,
          //           ),
          //           3.horizontalSpace,
          //           Text(
          //             "call customer",
          //             style: FontPalette.grey12400,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // 5.verticalSpace,
          Consumer<HomeProvider>(
            builder: (context, homeprovider, child) => Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      homeprovider.total = 0;
                      int lens = len ?? 0;
                      for (int i = 0; i < lens; i++) {
                        double amt = double.parse("${items![i].subTotal}");
                        homeprovider.totalamount(amt);
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewclothScreen(
                          items: items,
                          image: image,
                          orderno: number,
                          note: note,
                          customermobile: mobile,
                        ),
                      ));
                    },
                    child: Container(
                      height: 37.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border:
                              Border.all(color: Color.fromRGBO(0, 141, 108, 1))
                          // color: Color.fromARGB(255, 173, 217, 241),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "View Cloth Details",
                            style: FontPalette.black11600,
                          ),
                          const Icon(Icons.keyboard_arrow_right_outlined)
                        ],
                      ).horizontalPadding(15.w).verticalPadding(8.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Row(
            children: [
              Text(
                "Service Type: ",
                style: FontPalette.black11500,
              ),
              Text(
                items != null && items!.isNotEmpty
                    ? "${items![0].item?.serviceName}"
                    : "-",
                style: FontPalette.green11500,
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          //       decoration: BoxDecoration(
          //           color: Color.fromRGBO(2, 94, 57, 1),
          //           borderRadius: BorderRadius.circular(12.r)),
          //       child: Text(
          //         "Complete",
          //         style: FontPalette.white12500,
          //       ),
          //     ),
          //   ],
          // )
        ],
      ).verticalPadding(5.h).horizontalPadding(15.w),
    ).verticalPadding(5.h);
  }
}

void makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    // Handle the case when the phone call cannot be launched
    throw 'Could not launch $phoneUri';
  }
}
