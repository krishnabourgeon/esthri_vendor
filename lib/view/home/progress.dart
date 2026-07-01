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
import 'package:elaveoironing_vendor/view/home/completed.dart';
import 'package:elaveoironing_vendor/view/home/pending.dart';
import 'package:elaveoironing_vendor/view/home/viewcloths.dart';
import 'package:elaveoironing_vendor/viewmodel.dart/homeservice.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadProgress extends StatelessWidget {
  final int? index;
  final String? name;
  final String? id;
  final int? distance;
  final String? image;
  final double? lat;
  final double? long;
  const LoadProgress(
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
              ? LoadingProgress()
              : ProgressScreen();
        });
  }
}

class LoadingProgress extends StatefulWidget {
  const LoadingProgress({super.key});

  @override
  State<LoadingProgress> createState() => _LoadingProgressState();
}

class _LoadingProgressState extends State<LoadingProgress> {
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
        title: Text(
          "Progress",
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

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  precache() async {
    final home = context.read<HomeProvider>();
    int? len = home.pendingdata?.orders?.length;
    for (int i = 0; i < len!; i++) {
      int lenimage = home.pendingdata?.orders![i].orderImages?.length ?? 0;
      print("image len...$lenimage");
      for (int n = 0; n < lenimage; n++) {
        await precacheImage(
            NetworkImage(
                "${home.pendingdata?.orders![i].orderImages![n].filePath}"),
            context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        //centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Progress",
          style: FontPalette.black23600,
        ),
      ),
      body: Consumer<HomeProvider>(
          builder: (context, homeprovider, child) => RefreshIndicator(
                color: Color.fromRGBO(0, 141, 108, 1),
                onRefresh: () async {
                  await homeprovider.pending(status: 2);
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
                              itemCount:
                                  homeprovider.pendingdata?.orders?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                precache();
                                print(homeprovider.pendingdata?.orders?.length);
                                return ContainerBooking(
                                  orderid: homeprovider
                                      .pendingdata?.orders![index].orderId,
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
                                  time:
                                      "${homeprovider.pendingdata?.orders![index].dropoffTimeSlot?.startTime}-${homeprovider.pendingdata?.orders![index].dropoffTimeSlot?.endTime}",
                                  image: homeprovider
                                      .pendingdata?.orders![index].orderImages,
                                  note: homeprovider
                                      .pendingdata?.orders![index].note,
                                  count: homeprovider
                                      .pendingdata?.orders![index].count,
                                  onPressed: () {
                                    opendialog(
                                        context: context,
                                        orderitem: homeprovider.pendingdata
                                            ?.orders![index].orderItems,
                                        value1: false,
                                        id: homeprovider.pendingdata
                                            ?.orders![index].orderId);
                                  },
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
  final String? date;
  final String? place;
  final int? orderid;
  final String? name;
  final String? note;
  final List<OrderImages>? image;
  final String? mobile;
  final int? len;
  final List<OrderItems>? items;
  final String? deliveryboy;
  final int? count;
  final String? address;
  final VoidCallback? onPressed;
  const ContainerBooking(
      {super.key,
      this.date,
      this.note,
      this.count,
      this.mobile,
      this.orderid,
      this.items,
      this.number,
      this.image,
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
      borderradius: 12.r,
      boxcolor: "FFFFF",
      bordercolor: Color.fromRGBO(207, 209, 208, 1),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Color.fromRGBO(0, 141, 108, 1)),
                              child: Text(
                                "Order No: $number",
                                style: FontPalette.white12500,
                              ).symmetricPadding(
                                  vertical: 10.h, horizontal: 10.w),
                            ),
                          ),
                          // Text(
                          //   "Delivery Time",
                          //   style: FontPalette.grey11400,
                          // ),
                        ],
                      ),
                      10.verticalSpace,
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
                                  style: FontPalette.black13400,
                                ),
                                Text(
                                  "$place",
                                  style: FontPalette.grey11400,
                                ),
                              ],
                            ),
                          ),
                          //    5.horizontalSpace,
                          // Container(
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(13.r),
                          //       // color: Color.fromARGB(255, 83, 163,
                          //       // 200)
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Color.fromARGB(255, 39, 96, 167)
                          //               .withOpacity(1),
                          //           spreadRadius: 1,
                          //           blurRadius: 1,
                          //           offset: const Offset(4, 4), // X, Y offset
                          //         ),
                          //         BoxShadow(
                          //           color: Color.fromARGB(255, 39, 96, 167),
                          //           spreadRadius: 1,
                          //           blurRadius: 2,
                          //         ),
                          //       ],
                          //       color: Colors.white),
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         "Expected Delivery Time",
                          //         style: FontPalette.grey11400,
                          //       ),
                          //       Text(
                          //         "$formattedDate",
                          //         style: FontPalette.black10500,
                          //       ),
                          //       Text(
                          //         "$time",
                          //         style: FontPalette.black10500,
                          //       )
                          //     ],
                          //   ).verticalPadding(5.h).horizontalPadding(10.w),
                          // ),
                        ],
                      ),
                      10.verticalSpace,
                      Container(
                        color: Colors.grey,
                        height: 1.h,
                      ),
                      15.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 10.verticalSpace,
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
          formattedDate == "null"
              ? SizedBox()
              : Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
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
          10.verticalSpace,
          Consumer<HomeProvider>(
            builder: (context, homeprovider, child) => Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => makePhoneCall(mobile.toString()),
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
                              style: FontPalette.black10500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                                  label: Text(
                                      count == null ? '0' : count.toString()),
                                  child: Image.asset("assets/msg.png"),
                                ),
                                10.horizontalSpace,
                                Text(
                                  "Complaint",
                                  style: FontPalette.black10500,
                                )
                              ],
                            ).horizontalPadding(5.w),
                    ),
                  ),
                ),
              ],
            ),
          ),
          5.verticalSpace,
          Consumer<HomeProvider>(
            builder: (context, homeprovider, child) => InkWell(
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
                    note: note,
                    orderno: number,
                    customermobile: mobile,
                  ),
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Color.fromRGBO(0, 141, 108, 1))
                    // color: Color.fromARGB(255, 197, 238, 231).withOpacity(1),
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
          10.verticalSpace,
          Row(
            children: [
              Text(
                "Service Type: ",
                style: FontPalette.black11500,
              ),
              Text(
                "${items![0].item?.serviceName}",
                style: FontPalette.green11500,
              ),
            ],
          ),
          5.verticalSpace,
          Consumer<HomeProvider>(builder: (context, myNotifier, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // InkWell(
                //   // onTap: () => makePhoneCall(mobile.toString()),
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(vertical: 8.w),
                //     child: Row(
                //       children: [
                //         const Icon(
                //           Icons.phone_in_talk_rounded,
                //           color: Colors.black,
                //         ),
                //         3.horizontalSpace,
                //         Text(
                //           "call customer",
                //           style: FontPalette.grey12400,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // myNotifier.switchValue == false
                //     ? Container(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(13.r),
                //             color: HexColor('FD8D5D')),
                //         child: Row(
                //           children: [
                //             Icon(
                //               Icons.access_time,
                //               size: 15.sp,
                //               color: Colors.white,
                //             ),
                //             4.horizontalSpace,
                //             Text("Waiting for the delivery boy",
                //                 style: FontPalette.white14500)
                //           ],
                //         ).horizontalPadding(10.w).verticalPadding(7.h),
                //       )
                //     :
                CustomButton(
                  width: 85.w,
                  height: 35.h,
                  onTap: onPressed,
                  text: "Complete",
                  color: Color.fromRGBO(2, 94, 57, 1),
                  //color: Color.fromARGB(255, 115, 171, 197),
                  fontStyle: FontPalette.white12500,
                ),
              ],
            );
          })
        ],
      ).verticalPadding(15.h).horizontalPadding(15.w),
    ).verticalPadding(7.h);
  }
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
                      borderradius: 8.r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 140.w,
                              child: Text(
                                  "${orderitem![index].qty} X ${orderitem[index].item?.name}")),
                          Checkbox(
                            checkColor: Colors.green,
                            fillColor: WidgetStateProperty.all(Colors.white),
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
                      .changestatus(status: 3, orderid: id)
                      .catchError((error) {
                    Helpers.showToast(error);
                    isLoading.value = false;
                    return error;
                  });
                  if (res ?? false) {
                    await data.pending(status: 3);
                    await data.getcount();
                    isLoading.value = false;
                    Navigator.of(context).pop(true); // Return true on confirm
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LoadCompleted(),
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

Future<void> showConfirmationDialog(
  BuildContext context,
  int? id,
) async {
  final data = context.read<HomeProvider>();
  final services = GetIt.instance<HomeServices>();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Prevent closing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('Are you sure you want to proceed?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) => ElevatedButton(
              child: isLoading.value == true
                  ? CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : Text('Confirm'),
              onPressed: () async {
                isLoading.value = true;
                final res = await services
                    .changestatus(status: 3, orderid: id)
                    .catchError((error) {
                  Helpers.showToast(error);
                  isLoading.value = false;
                  return error;
                });
                await data.pending(status: 2);
                isLoading.value = false;
                if (res ?? false) {
                  Navigator.of(context).pop(true); // Return true on confirm
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
