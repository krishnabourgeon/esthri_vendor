import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/app_config.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_container.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/view/home/reportview.dart';

class Loadreport extends StatelessWidget {
  final int? index;
  final String? name;
  final String? id;
  final int? distance;
  final String? image;
  final double? lat;
  final double? long;
  const Loadreport(
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
        selector: (context, provider) => provider.reportLoaderState,
        builder: (context, value, child) {
          return (value == LoaderState.loading)
              ? Loadingreport()
              : CollectionReport();
        });
  }
}

class Loadingreport extends StatefulWidget {
  const Loadingreport({super.key});

  @override
  State<Loadingreport> createState() => _LoadingreportState();
}

class _LoadingreportState extends State<Loadingreport> {
  int i = 1;

  @override
  Widget build(BuildContext context) {
    // final data = context.read<WalletProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
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

class CollectionReport extends StatefulWidget {
  const CollectionReport({super.key});

  @override
  State<CollectionReport> createState() => _CollectionReportState();
}

class _CollectionReportState extends State<CollectionReport> {
  // Function to show the date picker
  Future<void> selectfromDate(BuildContext context) async {
    final model = context.read<HomeProvider>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date as the default
      firstDate: DateTime(2000), // Earliest date selectable
      lastDate: DateTime(2101), // Latest date selectable
    );
    if (picked != null) model.updatefromdate(picked);
  }

  Future<void> selecttoDate(BuildContext context) async {
    final model = context.read<HomeProvider>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date as the default
      firstDate: DateTime(2000), // Earliest date selectable
      lastDate: DateTime(2101), // Latest date selectable
    );
    if (picked != null) model.updatetodate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: true,
          //centerTitle: true,
          title: Text(
            "Collection Reports",
            style: FontPalette.black21400,
          ),
        ),
        body: SafeArea(
            child: Consumer<HomeProvider>(
          builder: (context, homeprovider, child) => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("From Date"),
                        InkWell(
                          onTap: () async {
                            await selectfromDate(context);
                            await homeprovider.report(
                                fromdata:
                                    "${DateFormat('yyyy-MM-dd').format(homeprovider.selectedfromDate!)}",
                                todate:
                                    "${DateFormat('yyyy-MM-dd').format(homeprovider.selectedtoDate!)}");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: HexColor("#02A278")),
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Center(
                              child: Text(
                                      "${DateFormat('dd-MM-yyyy').format(homeprovider.selectedfromDate!)}")
                                  .verticalPadding(10.h),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("To Date"),
                        InkWell(
                          onTap: () async {
                            await selecttoDate(context);
                            await homeprovider.report(
                                fromdata:
                                    "${DateFormat('yyyy-MM-dd').format(homeprovider.selectedfromDate!)}",
                                todate:
                                    "${DateFormat('yyyy-MM-dd').format(homeprovider.selectedtoDate!)}");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: HexColor("#02A278")),
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Center(
                              child: Text(
                                      "${DateFormat('dd-MM-yyyy').format(homeprovider.selectedtoDate!)}")
                                  .verticalPadding(10.h),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      10.verticalSpace,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //       height: 30.h,
                      //       width: 150.w,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(14.r),
                      //           border: Border.all(
                      //               color: HexColor('50BFA5'), width: 2.sp)),
                      //       child: TabBar(
                      //           labelPadding: EdgeInsets.all(5.sp),
                      //           indicatorSize: TabBarIndicatorSize.tab,
                      //           indicator: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(15.r),
                      //             color: HexColor("#15896E"),
                      //             // borderRadius: BorderRadius.circular(14.r),
                      //           ),
                      //           unselectedLabelColor: Colors.black,
                      //           labelStyle: FontPalette.white9500,
                      //           tabs: const [
                      //             Tab(
                      //               text: "Daily",
                      //             ),
                      //             Tab(
                      //               text: "Monthly",
                      //             ),
                      //             Tab(
                      //               text: "Yearly",
                      //             ),
                      //           ]),
                      //     ),
                      //   ],
                      // ),
                      // 30.verticalSpace,
                      Row(
                        children: [
                          CustomContainer(
                            // height: 85.h,
                            boxcolor: "E3F8F3",
                            borderradius: 14.r,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total Bookings",
                                      style: FontPalette.black13500,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${homeprovider.reportdata?.orders?.length ?? 0}",
                                      style: FontPalette.green30700,
                                    ),
                                  ],
                                )
                              ],
                            ).verticalPadding(10.h).horizontalPadding(10.w),
                          ),
                          5.horizontalSpace,
                          Expanded(
                            child: CustomContainer(
                              // height: 85.h,
                              boxcolor: "E3F8F3",
                              borderradius: 14.r,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Total Earnings",
                                        style: FontPalette.black13500,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "₹${homeprovider.reportdata?.totalOrderValue ?? 0}",
                                          style: FontPalette.green30700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ).horizontalPadding(10.w).verticalPadding(10.h),
                            ),
                          ),
                        ],
                      ),
                      10.verticalSpace,

                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "Order History",
                            style: FontPalette.black17500,
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Column(
                        children: [
                          homeprovider.reportdata?.orders?.length == 0 ||
                                  homeprovider.reportdata?.orders?.length ==
                                      '' ||
                                  homeprovider.reportdata?.orders?.length ==
                                      null
                              ? Text("No data found")
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      homeprovider.reportdata?.orders?.length ??
                                          0,
                                  itemBuilder: (context, index) {
                                    return CustomContainer(
                                      ontap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              ReportViewScreen(index: index),
                                        ));
                                      },
                                      boxcolor: 'F0F0F0',
                                      borderradius: 12.r,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${homeprovider.reportdata?.orders![index].orderNo}",
                                              style: FontPalette.black11500,
                                            ),
                                          ),
                                          Text(
                                            "₹${homeprovider.reportdata?.orders![index].orderValue}",
                                            style: FontPalette.black13600,
                                          )
                                        ],
                                      )
                                          .horizontalPadding(15.w)
                                          .verticalPadding(5.h),
                                    ).bottomPadding(8.h);
                                  }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).horizontalPadding(25.w).verticalPadding(10.h),
        )),
      ),
    );
  }
}
