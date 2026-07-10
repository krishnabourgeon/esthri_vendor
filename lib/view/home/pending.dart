import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:elaveoironing_vendor/datamodel/pending_datamodel.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/app_config.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_button.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_container.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/utils/helper/helpers.dart';
import 'package:elaveoironing_vendor/view/home/progress.dart';
import 'package:elaveoironing_vendor/view/home/registercompaint_progress.dart';
import 'package:elaveoironing_vendor/view/home/registercomplaint.dart';
import 'package:elaveoironing_vendor/view/home/viewcloths.dart';
import 'package:elaveoironing_vendor/view/home/viewcomplaint_progress.dart';
import 'package:elaveoironing_vendor/viewmodel.dart/homeservice.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadPending extends StatelessWidget {
  final int? index;
  final String? name;
  final String? id;
  final int? distance;
  final String? image;
  final double? lat;
  final double? long;
  const LoadPending(
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
          return (value == LoaderState.loading) ? LoadingPending() : NewOrder();
        });
  }
}

class LoadingPending extends StatefulWidget {
  const LoadingPending({super.key});

  @override
  State<LoadingPending> createState() => _LoadingPendingState();
}

class _LoadingPendingState extends State<LoadingPending> {
  int i = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        //centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Pending",
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

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
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
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text(
            "Pending",
            style: FontPalette.black23500,
          ),
        ),
        body: Consumer<HomeProvider>(
          builder: (context, homeprovider, child) => RefreshIndicator(
            color: Color.fromRGBO(0, 141, 108, 1),
            onRefresh: () async {
              await homeprovider.pending(status: 1);
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(children: [
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
                        itemCount: homeprovider.pendingdata?.orders?.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          precache();
                          print(homeprovider.pendingdata?.orders?.length);
                          return ContainerBooking(
                            orderstatus: homeprovider
                                .pendingdata?.orders![index].orderstatus,
                            orderid: homeprovider
                                .pendingdata?.orders![index].orderId,
                            daccode: homeprovider
                                .pendingdata?.orders![index].dacCode,
                            number:
                                "${homeprovider.pendingdata?.orders![index].orderNo}",
                            len: homeprovider.pendingdata?.orders![index]
                                    .orderItems?.length ??
                                0,
                            customermobile:
                                "${homeprovider.pendingdata?.orders![index].customerPhone}",
                            agentmobile:
                                "${homeprovider.pendingdata?.orders![index].pickupDeliveryAgentMobile}",
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
                            time:
                                "${homeprovider.pendingdata?.orders![index].dropoffTimeSlot?.startTime}-${homeprovider.pendingdata?.orders![index].dropoffTimeSlot?.endTime}",
                            image: homeprovider
                                .pendingdata?.orders![index].orderImages,
                            note: homeprovider.pendingdata?.orders![index].note,
                            count:
                                homeprovider.pendingdata?.orders![index].count,
                            onPressed: () {
                              opendialog(
                                  context: context,
                                  orderitem: homeprovider
                                      .pendingdata?.orders![index].orderItems,
                                  value1: false,
                                  id: homeprovider
                                      .pendingdata?.orders![index].orderId);
                            },
                          ).horizontalPadding(20.w);
                        }),
              ]),
            ),
          ),
        ));
  }
}

class ContainerBooking extends StatelessWidget {
  final String? number;
  final String? time;
  final int? daccode;
  final String? date;
  final int? orderstatus;
  final String? place;
  final String? note;
  final int? orderid;
  final List<OrderImages>? image;
  final String? name;
  final String? customermobile;
  final String? agentmobile;
  final int? len;
  final List<OrderItems>? items;
  final String? deliveryboy;
  final String? address;
  final int? count;
  final VoidCallback? onPressed;
  const ContainerBooking(
      {super.key,
      this.date,
      this.image,
      this.note,
      this.orderstatus,
      this.count,
      this.daccode,
      this.customermobile,
      this.agentmobile,
      this.items,
      this.number,
      this.orderid,
      this.len,
      this.name,
      this.deliveryboy,
      this.time,
      this.place,
      this.onPressed,
      this.address});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
    String formattedDate = date == "null"
        ? "null"
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(date!));
    return CustomContainer(
      borderradius: 20.r,
      boxcolor: "FFFFF",
      bordercolor: Color.fromRGBO(207, 209, 208, 1),
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
                            color: Color.fromRGBO(0, 141, 108, 1)
                            // gradient: LinearGradient(colors: [
                            //   Color.fromARGB(255, 78, 211, 189).withOpacity(1),
                            //   Color.fromARGB(255, 39, 96, 167),
                            // ])
                            ),
                        child: Row(
                          children: [
                            Text(
                              "DAC Code: $daccode",
                              style: FontPalette.white12500,
                            )
                          ],
                        ).symmetricPadding(vertical: 10.h, horizontal: 10.w),
                      ),
                      5.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "$number",
                              style: FontPalette.black12400,
                            ),
                          ),
                          // Text(
                          //   "Delivery Time",
                          //   style: FontPalette.grey11400,
                          // ),
                        ],
                      ),
                      5.verticalSpace,
                      Column(
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
                          // InkWell(
                          //   onTap: () =>
                          //       makePhoneCall(customermobile.toString()),
                          //   child: Padding(
                          //     padding:
                          //         EdgeInsets.symmetric(vertical: 10.w),
                          //     child: Container(
                          //       padding: EdgeInsets.symmetric(
                          //           vertical: 5.w, horizontal: 5.w),
                          //       decoration: BoxDecoration(
                          //           border: Border.all(
                          //               color: Color.fromRGBO(
                          //                   0, 141, 108, 1)),
                          //           borderRadius:
                          //               BorderRadius.circular(12.r)),
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
                          10.verticalSpace,
                          Container(
                            height: 1.h,
                            color: Colors.grey,
                          ),
                          10.verticalSpace,
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
                          // 15.verticalSpace,
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 7.verticalSpace,
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
          deliveryboy == "null" || deliveryboy == null
              ? SizedBox()
              : 15.verticalSpace,
          Consumer<HomeProvider>(
            builder: (context, homeprovider, child) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => makePhoneCall(customermobile.toString()),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          child: Container(
                            height: 37.h,
                            padding: EdgeInsets.symmetric(
                                vertical: 5.w, horizontal: 5.w),
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
                                  style: FontPalette.black11500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: InkWell(
                    //     onTap: () {
                    //       homeprovider.total = 0;
                    //       int lens = len ?? 0;
                    //       for (int i = 0; i < lens; i++) {
                    //         double amt = double.parse("${items![i].subTotal}");

                    //         homeprovider.totalamount(amt);
                    //       }
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => ViewclothScreen(
                    //             orderno: number,
                    //             customermobile: customermobile,
                    //             deliveryboymobile:
                    //                 deliveryboy == "null" || deliveryboy == null
                    //                     ? null
                    //                     : agentmobile,
                    //             image: image,
                    //             items: items,
                    //             note: note),
                    //       ));
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(12.r),
                    //           color: Color.fromARGB(255, 147, 189, 223)),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             "View Cloth Details",
                    //             style: FontPalette.black12600,
                    //           ),
                    //           const Icon(
                    //             Icons.keyboard_arrow_right_outlined,
                    //             color: Colors.black,
                    //           )
                    //         ],
                    //       ).horizontalPadding(10.w).verticalPadding(8.h),
                    //     ),
                    //   ),
                    // ),
                    5.horizontalSpace,
                    ValueListenableBuilder<bool>(
                      valueListenable: isLoading,
                      builder: (context, value, child) => InkWell(
                        onTap: () async {
                          isLoading.value = true;
                          homeprovider.selectedComplaint = null;
                          await homeprovider.getcomplaint(orderid: orderid);
                          showComplaintOptions(context, orderid, len);
                          isLoading.value = false;
                        },
                        child: Container(
                          height: 37.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: HexColor("#008D6C")),
                            borderRadius: BorderRadius.circular(10.r),
                            //color: Color.fromARGB(255, 147, 189, 223)
                          ),
                          child: isLoading.value
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Row(
                                  children: [
                                    Badge(
                                      largeSize: 10.w,
                                      label: Text(count == null
                                          ? '0'
                                          : count.toString()),
                                      child: Image.asset("assets/msg.png"),
                                    ),
                                    10.horizontalSpace,
                                    Text(
                                      "Complaint",
                                      style: FontPalette.black11500,
                                    )
                                  ],
                                ).horizontalPadding(10.w),
                        ),
                      ),
                    ),
                  ],
                ),
                //   5.verticalSpace,
                InkWell(
                  onTap: () {
                    homeprovider.total = 0;
                    int lens = len ?? 0;
                    for (int i = 0; i < lens; i++) {
                      double amt = double.parse("${items![i].subTotal}");
                      homeprovider.totalamount(amt);
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewclothScreen(
                          orderno: number,
                          customermobile: customermobile,
                          deliveryboymobile:
                              deliveryboy == "null" || deliveryboy == null
                                  ? null
                                  : agentmobile,
                          image: image,
                          items: items,
                          note: note),
                    ));
                  },
                  child: Container(
                    height: 37.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(0, 141, 108, 1)),
                      borderRadius: BorderRadius.circular(12.r),
                      //  color: Color.fromARGB(255, 147, 189, 223)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "View Cloth Details",
                          style: FontPalette.black11500,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.black,
                        )
                      ],
                    ).horizontalPadding(10.w).verticalPadding(5.h),
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
                items != null && items!.isNotEmpty ? "${items![0].item?.serviceName ?? 'N/A'}" : "N/A",
                style: FontPalette.green11500,
              ),
            ],
          ),
          5.verticalSpace,
          deliveryboy == "null" || deliveryboy == null || orderstatus == 2
              ? SizedBox()
              : 10.verticalSpace,

          AppConfig.settings == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    deliveryboy == "null" || deliveryboy == null
                        ? SizedBox()
                        : Expanded(
                            child: InkWell(
                              onTap: () =>
                                  makePhoneCall(agentmobile.toString()),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone_in_talk_outlined,
                                    color: HexColor("#008D6C"),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Call Delivery Agent",
                                        style: FontPalette.black11500,
                                      ),
                                      Text(
                                        "($deliveryboy)",
                                        style: FontPalette.black11500,
                                      )
                                    ],
                                  ).horizontalPadding(10.w),
                                ],
                              ),
                            ),
                          ),
                    5.horizontalSpace,
                    orderstatus == 2
                        ? CustomButton(
                            width: 85.w,
                            height: 39.h,
                            onTap: onPressed,
                            text: "Start",
                            color: AppColors.primaryDark,
                            fontStyle: FontPalette.white12500,
                          )
                        : SizedBox(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      width: 85.w,
                      height: 39.h,
                      onTap: onPressed,
                      text: "Start",
                      color: AppColors.primaryDark,
                      fontStyle: FontPalette.white12500,
                    )
                  ],
                )
        ],
      ).verticalPadding(5.h).horizontalPadding(10.w),
    ).verticalPadding(7.h);
  }
}

void showComplaintOptions(BuildContext context, int? orderid, int? len) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add, color: Colors.blue),
              title: const Text('Register Complaint'),
              onTap: () {
                Navigator.pop(context); // Close the Bottom Sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegisterComplaintScreenprogres(orderid: orderid)),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.view_list, color: Colors.green),
              title: const Text('View Complaints'),
              onTap: () {
                if (len == 0) {
                  Helpers.showToast("No complaints found.");
                } else {
                  Navigator.pop(context); // Close the Bottom Sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ViewComplaintsScreenprogress(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

opendialog(
    {BuildContext? context,
    bool value1 = false,
    int? id,
    List<OrderItems>? orderitem}) async {
  final services = GetIt.instance<HomeServices>();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  List<bool> checkboxValues = [];
  checkboxValues = List.generate(orderitem?.length ?? 0, (_) => false);
  await showDialog(
    barrierDismissible: false,
    context: context!,
    builder: (BuildContext context) {
      final data = context.read<HomeProvider>();
      return AlertDialog(
        backgroundColor: Colors.white,
        scrollable: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Collect items',
              style: FontPalette.green17500,
            ),
          ],
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                const Divider(),
                InkWell(
                    onTap: () {
                      setState(() {
                        if (checkboxValues.every((value) => value == true)) {
                          value1 = false;
                          checkboxValues =
                              List.filled(checkboxValues.length, false);
                        } else {
                          value1 = true;
                          checkboxValues = List.filled(checkboxValues.length,
                              true); // Set all values to true
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Check all",
                          style: FontPalette.black13500,
                        ),
                        Checkbox(
                          checkColor: Colors.green,
                          fillColor: WidgetStateProperty.all(Colors.white),
                          value: value1,
                          onChanged: (value) {
                            setState(() {
                              value1 = value!;
                              if (value1 == true) {
                                checkboxValues =
                                    List.filled(checkboxValues.length, true);
                              } else {
                                checkboxValues =
                                    List.filled(checkboxValues.length, false);
                              }
                            });
                          },
                        )
                      ],
                    )).horizontalPadding(10.w),
                10.verticalSpace,
                Column(
                  children: List.generate(orderitem?.length ?? 0, (int index) {
                    return CustomContainer(
                      boxcolor: '#DDE4E5',
                      // bordercolor: '#DDE4E5',
                      borderradius: 8.r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 110.w,
                            child: Text(
                                "${orderitem![index].qty} X ${orderitem[index].item?.name}"),
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop(false);
                                    print(orderitem[index].id);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterComplaintScreenpending(
                                              orderitemid: orderitem[index]
                                                  .item
                                                  ?.itemPriceChartId,
                                              orderid: id),
                                    ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(3.w),
                                    child: const Icon(
                                      Icons.message,
                                      color: Colors.black,
                                    ),
                                  )),
                              Checkbox(
                                checkColor: Colors.green,
                                fillColor:
                                    WidgetStateProperty.all(Colors.white),
                                value: checkboxValues[
                                    index], // Get the state for each checkbox
                                onChanged: (value) {
                                  setState(() {
                                    checkboxValues[index] =
                                        value ?? false; // Update the state
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ).horizontalPadding(10.w),
                    ).bottomPadding(10.h);
                  }),
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: HexColor("#577D86")),
            ),
            onPressed: () async {
              Navigator.of(context).pop(false); // Return true on confirm
            },
          ),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) => ElevatedButton(
              child: isLoading.value == true
                  ? CircularProgressIndicator(
                      color: HexColor("#577D86"),
                    )
                  : Text(
                      'Confirm',
                      style: TextStyle(color: HexColor("#577D86")),
                    ),
              onPressed: () async {
                if (checkboxValues.every((value) => value == true)) {
                  isLoading.value = true;
                  final res = await services
                      .changestatus(status: 2, orderid: id)
                      .catchError((error) {
                    Helpers.showToast(error);
                    isLoading.value = false;
                    return error;
                  });

                  if (res ?? false) {
                    await data.pending(status: 2);
                    await data.getcount();
                    isLoading.value = false;
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LoadProgress(),
                    ));
                  } else {
                    isLoading.value = false;
                  }
                } else {
                  isLoading.value = false;
                  Helpers.showToast("Please confirm your collected items");
                }
              },
            ),
          ),
        ],
      );
    },
  );
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
