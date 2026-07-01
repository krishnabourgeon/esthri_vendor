import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';

class ReportViewScreen extends StatefulWidget {
  const ReportViewScreen({super.key, this.index});
  final int? index;
  @override
  State<ReportViewScreen> createState() => _ReportViewScreenState();
}

class _ReportViewScreenState extends State<ReportViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
        // centerTitle: true,
        title: Text(
          "Collection Reports",
          style: FontPalette.black21400,
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, homeprovider, child) {
        DateTime dateTime = DateTime.parse(
            "${homeprovider.reportdata?.orders![widget.index!].actualPickupTime}");
        // Format the date as "dd-MM-yyyy"
        String formattedpickupDate = DateFormat("dd-MM-yyyy").format(dateTime);
        String formattedpickupTime = DateFormat("hh:mm a").format(dateTime);
        DateTime dateTime1 = homeprovider
                    .reportdata?.orders![widget.index!].actualDropoffTime ==
                null
            ? DateTime.now()
            : DateTime.parse(
                "${homeprovider.reportdata?.orders![widget.index!].actualDropoffTime}");
        // Format the date as "dd-MM-yyyy"
        String formatteddropDate =
            homeprovider.reportdata?.orders![widget.index!].actualDropoffTime ==
                    null
                ? "null"
                : DateFormat("dd-MM-yyyy").format(dateTime1);
        String formatteddropTime =
            homeprovider.reportdata?.orders![widget.index!].actualDropoffTime ==
                    null
                ? "null"
                : DateFormat("hh:mm a").format(dateTime1);
        return Column(
          children: [
            20.verticalSpace,
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(207, 209, 208, 1),
                  ),
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 141, 108, 1),
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Text(
                            "Order No: ${homeprovider.reportdata?.orders![widget.index!].orderNo}",
                            style: FontPalette.white12500,
                          ).symmetricPadding(vertical: 13.h, horizontal: 13.w),
                        ),
                      ),
                      // Text(
                      //     "Amount: ${homeprovider.reportdata?.orders![widget.index!].orderValue}",
                      //     style: FontPalette.anodark15500),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${homeprovider.reportdata?.orders![widget.index!].customerName}",
                            style: FontPalette.grey11400,
                          ),
                          Row(
                            children: [
                              Text(
                                "Ph : ",
                                style: FontPalette.black11600,
                              ),
                              Text(
                                  "${homeprovider.reportdata?.orders![widget.index!].customerPhone}",
                                  style: FontPalette.black12400),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(184, 184, 184, 1)),
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Text(
                          "Amount: ₹${homeprovider.reportdata?.orders![widget.index!].orderValue}",
                          style: FontPalette.black11600,
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Paid - ${homeprovider.reportdata?.orders![widget.index!].modeOfPayment}",
                        style: FontPalette.grey11400,
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Container(
                    height: 1.h,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(148, 147, 147, 1)),
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              "Pickup Time",
                              style: FontPalette.blue11700,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              "Dropoff Time",
                              style: FontPalette.blue11700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(3, 149, 91, 1).withOpacity(1),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text(
                            //   "Pickup Time",
                            //   style: FontPalette.white12500,
                            // ),
                            Text(
                              formattedpickupTime,
                              style: FontPalette.white15500,
                            ),
                            //3.verticalSpace,
                            Text(
                              formattedpickupDate,
                              style: FontPalette.white12500,
                            ),
                            3.verticalSpace,
                            Text(
                              "${homeprovider.reportdata?.orders![widget.index!].pickupDeliveryAgentName ?? ''}",
                              style: FontPalette.white12500,
                            )
                          ],
                        ).verticalPadding(10.h),
                      )),
                      10.horizontalSpace,
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(5, 157, 66, 1),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text(
                            //   "Dropoff Time",
                            //   style: FontPalette.white12500,
                            // ),
                            Text(
                              formatteddropTime == 'null'
                                  ? ''
                                  : formatteddropTime,
                              style: FontPalette.white15500,
                            ),
                            //3.verticalSpace,
                            Text(
                              formatteddropDate == 'null'
                                  ? ''
                                  : formatteddropDate,
                              style: FontPalette.white12500,
                            ),
                            Text(
                              "${homeprovider.reportdata?.orders![widget.index!].dropoffDeliveryAgentName ?? ''}",
                              style: FontPalette.white12500,
                            )
                          ],
                        ).verticalPadding(10.h),
                      ))
                    ],
                  ),
                  //   Text("Pickup Time: 20-12-22 12:30 PM", style: FontPalette.black13400,) ,
                  //  Text("Dropoff Time: 20-12-25 12:30 PM", style: FontPalette.black13400)
                ],
              ).horizontalPadding(20.w).verticalPadding(20.h),
            )
          ],
        ).horizontalPadding(20.w);
      }),
    );
  }
}
