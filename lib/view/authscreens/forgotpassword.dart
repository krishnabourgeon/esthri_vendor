import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_button.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_tertformfield.dart';
import 'package:elaveoironing_vendor/utils/helper/appbar.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:elaveoironing_vendor/view/authscreens/verification.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Row(
              children: [
                BackBUtton(
                  ontap: () => Navigator.of(context).pop(),
                )
              ],
            ),
            40.verticalSpace,
            Row(
              children: [
                Text(
                  "Forgot password?",
                  style: FontPalette.black23600,
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Don't worry it happens. Please enter the phone number associated with your account",
                    style: FontPalette.lightblack13600,
                  ),
                ),
              ],
            ),
            50.verticalSpace,
            Row(
              children: [
                Text(
                  "Enter your phone number",
                  style: FontPalette.lightblack14500,
                ),
              ],
            ),
            5.verticalSpace,
            CustomText(
              semanticlabel: "Enter your phone number",
              controller: phoneController,
              style: FontPalette.f00C159_9Medium,
            ),
            60.verticalSpace,
            CustomButton(
              color: HexColor("569DAA"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const VerificationScreen(),
              )),
              text: "Send code",
            )
          ],
        ).horizontalPadding(15.w).verticalPadding(25.h),
      )),
    );
  }
}
