import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_button.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:elaveoironing_vendor/utils/helper/helpers.dart';
import 'package:elaveoironing_vendor/view/home/viewcomplaints.dart';
import 'package:elaveoironing_vendor/viewmodel.dart/homeservice.dart';

class RegisterComplaintScreenprogres extends StatelessWidget {
  const RegisterComplaintScreenprogres(
      {super.key, this.orderid, this.orderitemid});
  final int? orderid;
  final int? orderitemid;
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLoadingbutton = ValueNotifier<bool>(false);
    final TextEditingController descriptionController = TextEditingController();
    final services = GetIt.instance<HomeServices>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Register Complaint",
          style: FontPalette.black23500,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<HomeProvider>(
              builder: (context, homeprovider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Complaints:',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: homeprovider.complaints.map((complaint) {
                            return Row(
                              children: [
                                Radio<String>(
                                  value: complaint,
                                  groupValue: homeprovider.selectedComplaint,
                                  onChanged: (value) {
                                    homeprovider.updatecomplaint(value);
                                  },
                                ),
                                TextButton(
                                    style: const ButtonStyle(
                                        overlayColor: WidgetStatePropertyAll(
                                            Colors.transparent)),
                                    onPressed: () {
                                      homeprovider.updatecomplaint(complaint);
                                    },
                                    child: Text(
                                      complaint,
                                      style: FontPalette.black13400,
                                    )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Additional Comment (Optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  20.verticalSpace,
                  CustomButton(
                    isLoading: isLoadingbutton,
                    onTap: () async {
                      if (descriptionController.text.isNotEmpty ||
                          homeprovider.selectedComplaint != null) {
                        isLoadingbutton.value = true;
                        final res = await services
                            .complaint(
                          orderid: orderid,
                          orderitemid: orderitemid,
                          desc:
                              "${homeprovider.selectedComplaint}${homeprovider.selectedComplaint == null || descriptionController.text.isEmpty ? "" : ","} ${descriptionController.text}",
                        )
                            .catchError((error) {
                          isLoadingbutton.value = false;
                          return error;
                        });
                        if (res ?? false) {
                          await homeprovider.getcomplaint(orderid: orderid);
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ViewComplaintsScreenpending(),
                              ),
                            );
                          }
                          isLoadingbutton.value = false;
                        } else {
                          isLoadingbutton.value = false;
                        }
                      } else {
                        Helpers.showToast("Please enter your complaints.");
                      }
                    },
                    color: const Color.fromRGBO(29, 151, 162, 1),
                    text: "Submit",
                    fontStyle: FontPalette.white14400,
                  )
                ],
              ),
            ),
          ],
        ).symmetricPadding(vertical: 20.h, horizontal: 20.w),
      ),
    );
  }
}
