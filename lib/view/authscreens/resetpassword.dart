import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_button.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_tertformfield.dart';
import 'package:elaveoironing_vendor/utils/helper/appbar.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:elaveoironing_vendor/view/authscreens/loginpage.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> showPassword2 = ValueNotifier<bool>(true);
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
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
                ),
              ],
            ),
            30.verticalSpace,
            Row(
              children: [
                Text(
                  "Reset password",
                  style: FontPalette.black23600,
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Please write your new password",
                    style: FontPalette.lightblack13600,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              children: [
                Text(
                  "New password",
                  style: FontPalette.lightblack14500,
                ),
              ],
            ),
            5.verticalSpace,
            ValueListenableBuilder<bool>(
                valueListenable: showPassword,
                builder: (context, value, child) {
                  return CustomText(
                    semanticlabel: "Enter your password",
                    controller: passwordController1,
                    maxlines: 1,
                    suffixWidget: InkWell(
                      onTap: () {
                        showPassword.value = !showPassword.value;
                      },
                      child: SizedBox.square(
                        dimension: 49.h,
                        child: Icon(
                          semanticLabel: value
                              ? "password is not visible"
                              : "password is visible",
                          value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20.r,
                          color: HexColor("#7A7A7A"),
                        ),
                      ),
                    ),
                    style: FontPalette.f00C159_9Medium,
                    obscureText: value,
                  );
                }),
            7.verticalSpace,
            Row(
              children: [
                Text(
                  "Confirm password",
                  style: FontPalette.lightblack14500,
                ),
              ],
            ),
            5.verticalSpace,
            ValueListenableBuilder<bool>(
                valueListenable: showPassword2,
                builder: (context, value, child) {
                  return CustomText(
                    semanticlabel: "Enter your password",
                    controller: passwordController2,
                    maxlines: 1,
                    suffixWidget: InkWell(
                      onTap: () {
                        showPassword2.value = !showPassword2.value;
                      },
                      child: SizedBox.square(
                        dimension: 49.h,
                        child: Icon(
                          semanticLabel: value
                              ? "password is not visible"
                              : "password is visible",
                          value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20.r,
                          color: HexColor("#7A7A7A"),
                        ),
                      ),
                    ),
                    style: FontPalette.f00C159_9Medium,
                    obscureText: value,
                  );
                }),
            70.verticalSpace,
            CustomButton(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              )),
              text: "Send",
            ),
          ],
        ).verticalPadding(25.h).horizontalPadding(15.w),
      )),
    );
  }
}
