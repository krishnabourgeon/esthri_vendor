import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';

class ViewComplaintsScreenpending extends StatelessWidget {
  const ViewComplaintsScreenpending({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        final home = context.read<HomeProvider>();
        home.pending(status: 1);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text(
            "View Complaints",
            style: FontPalette.black23500,
          ),
        ),
        body: Consumer<HomeProvider>(
          builder: (context, homeprovider, child) {
            int? len = homeprovider.getcomplaintdata?.feedbacks?.length;
            return len == 0
                ? Column(
                    children: [
                      100.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No complaints found.",
                            style: FontPalette.grey15500,
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.verticalSpace,
                      Text(
                        'Complaint Details:',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      10.verticalSpace,
                      Expanded(
                        child: ListView.separated(
                            physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: homeprovider
                                    .getcomplaintdata?.feedbacks?.length ??
                                0,
                            separatorBuilder: (context, index) =>
                                5.verticalSpace,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 234, 239, 244),
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              softWrap: true,
                                              maxLines: null,
                                              overflow: TextOverflow.visible,
                                              "${homeprovider.getcomplaintdata?.feedbacks![index].description}"),
                                        ),
                                        homeprovider
                                                    .getcomplaintdata
                                                    ?.feedbacks![index]
                                                    .orderItem ==
                                                null
                                            ? const SizedBox()
                                            : Expanded(
                                                child: Row(
                                                  children: [
                                                    5.horizontalSpace,
                                                    Expanded(
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.right,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: null,
                                                        "${homeprovider.getcomplaintdata?.feedbacks![index].orderItem?.item?.name}",
                                                        style: FontPalette
                                                            .black13400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                    homeprovider.getcomplaintdata
                                                ?.feedbacks![index].agentId ==
                                            null
                                        ? homeprovider
                                                    .getcomplaintdata
                                                    ?.feedbacks![index]
                                                    .vendor ==
                                                null
                                            ? const SizedBox()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Reported by EV${homeprovider.getcomplaintdata?.feedbacks![index].vendor?.id}",
                                                    style:
                                                        FontPalette.black12600,
                                                  ),
                                                ],
                                              )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Reported by ED${homeprovider.getcomplaintdata?.feedbacks![index].agentId}",
                                                style: FontPalette.black12600,
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ).symmetricPadding(vertical: 15.h, horizontal: 20.w);
          },
        ),
      ),
    );
  }
}
