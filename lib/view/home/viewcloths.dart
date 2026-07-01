import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/datamodel/pending_datamodel.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:elaveoironing_vendor/view/home/completed.dart';
import 'package:elaveoironing_vendor/view/home/viewclothimages.dart';

class ViewclothScreen extends StatelessWidget {
  ViewclothScreen(
      {super.key,
      this.items,
      this.image,
      this.note,
      this.orderno,
      this.deliveryboymobile,
      this.customermobile});
  final List<OrderItems>? items;
  final List<OrderImages>? image;
  final String? note;
  final String? orderno;
  final String? customermobile;
  final String? deliveryboymobile;

  @override
  Widget build(BuildContext context) {
    void openBottomSheet({String? image}) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return InteractiveViewer(
            panEnabled: true, // Enable panning
            minScale: 1.0, // Minimum zoom scale
            maxScale: 4.0, // Maximum zoom scale
            child: Container(
              width: double.infinity,
              height: 600.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                      image: NetworkImage("$image"), fit: BoxFit.fill)),
            ).horizontalPadding(20.w),
          );
        },
      );
    }

    print("..image len....view..${image?.length}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Cloth Details",
          style: FontPalette.black21400,
        ),
        automaticallyImplyLeading: true,
        //  centerTitle: true,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            children: [
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 141, 108, 1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Text(
                        "Order No: $orderno",
                        style: FontPalette.white12500,
                      ),
                    ),
                  ),
                ],
              ),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => makePhoneCall(customermobile.toString()),
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.phone_in_talk_rounded,
                            color: Color.fromARGB(255, 13, 117, 169),
                          ),
                          3.horizontalSpace,
                          Text(
                            "call customer",
                            style: FontPalette.viewcloths12400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  5.horizontalSpace,
                  deliveryboymobile == null
                      ? SizedBox()
                      : InkWell(
                          splashColor: Colors.transparent,
                          onTap: () =>
                              makePhoneCall(deliveryboymobile.toString()),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.phone_in_talk_rounded,
                                  color: Color.fromARGB(255, 13, 117, 169),
                                ),
                                3.horizontalSpace,
                                Text(
                                  "call delivery boy",
                                  style: FontPalette.viewcloths12400,
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
              15.verticalSpace,
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => 8.verticalSpace,
                  itemCount: items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.r),
                          border: Border.all(
                              color: Color.fromRGBO(182, 214, 206, 1))
                          //  color: HexColor("#EAF4F6"),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Image.network(
                                    "${items![index].item?.icon}"),
                              ),
                              5.horizontalSpace,
                              SizedBox(
                                width: 140.w,
                                child: Text(
                                  "${items![index].item?.name ?? ''}",
                                  style: FontPalette.black13500,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Text(
                                textAlign: TextAlign.end,
                                "${items![index].qty} x ₹${items![index].unitPrice}",
                                style: FontPalette.black13500),
                          )
                        ],
                      ).verticalPadding(10.h).horizontalPadding(15.w),
                    );
                  }),
              20.verticalSpace,
              // Container(
              //   color: const Color.fromARGB(255, 224, 221, 221),
              //   height: 2.h,
              //   width: MediaQuery.of(context).size.width,
              // ),
              // 20.verticalSpace,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Total", style: FontPalette.black15500),
              //     Text("₹ ${value.total.toStringAsFixed(2)}",
              //         style: FontPalette.black15500)
              //   ],
              // ).horizontalPadding(20.w),
              20.verticalSpace,
              image?.length == 0 || image?.length == null
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Images",
                          style: FontPalette.grey15500,
                        ),
                        InkWell(
                          onTap: () {
                            print("..image len....view..${image?.length}");

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Viewclothimages(
                                image: image,
                              ),
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(0, 141, 108, 1)),
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Text("View all"),
                          ),
                        )
                      ],
                    ),
              image?.length == 0 || image?.length == null
                  ? const SizedBox()
                  : 5.verticalSpace,
              image?.length == 0 || image?.length == null
                  ? const SizedBox()
                  : SizedBox(
                      height: 60.h,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 260.h,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: image?.length ?? 0,
                                separatorBuilder: (context, index) =>
                                    5.horizontalSpace,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => openBottomSheet(
                                        image: image![index].filePath),
                                    child: Container(
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${image![index].filePath}"),
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                }),
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       border: Border.all(color: Colors.grey)),
                          //   child: Text("View all"),
                          // )
                        ],
                      ),
                    ),
              image?.length == 0 || image?.length == null
                  ? const SizedBox()
                  : 20.verticalSpace,
              note == null
                  ? SizedBox()
                  : Row(
                      children: [
                        Text(
                          "Note",
                          style: FontPalette.grey15500,
                        ),
                      ],
                    ),
              note == null
                  ? SizedBox()
                  : Row(
                      children: [
                        Text(
                          "$note",
                          style: FontPalette.black13400,
                        ),
                      ],
                    ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Total Amount", style: FontPalette.black13500),
                      Text("₹ ${value.total.toStringAsFixed(2)}",
                          style: FontPalette.blue21700)
                    ],
                  )
                ],
              ),
              // 30.verticalSpace,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Total", style: FontPalette.black15500),
              //     Text("₹ ${value.total.toStringAsFixed(2)}",
              //         style: FontPalette.black15500)
              //   ],
              // ).horizontalPadding(20.w),
            ],
          ).horizontalPadding(25.w).verticalPadding(10.h),
        ),
      ),
    );
  }
}
