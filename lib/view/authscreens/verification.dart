import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/countdown.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_button.dart';
import 'package:elaveoironing_vendor/utils/helper/appbar.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:elaveoironing_vendor/utils/helper/validator.dart';
import 'package:elaveoironing_vendor/view/home/homescreen.dart';

class VerificationScreen extends StatefulWidget {
  final String? phone;
  const VerificationScreen({Key? key, this.phone}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // final services = GetIt.instance<AuthServices>();
  String? otp;
  // final services = GetIt.instance<AuthServices>();

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  PinTheme defaultTheme(double width) => PinTheme(
        width: width,
        height: width,
        textStyle: FontPalette.black13500,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        margin: EdgeInsets.only(right: 21.w),
        decoration: BoxDecoration(
          color: HexColor("#EAF4F6"),
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(
            color: HexColor('#EAF4F6'),
          ),
        ),
      );

  final ValueNotifier<int> _currentMicroSeconds =
      ValueNotifier<int>(60 * 1000000);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Forgot password verification screen",
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Row(
                    children: [
                      BackBUtton(
                        ontap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "Phone number Verification",
                        style: FontPalette.black23600,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "We've send a code to phonenumber",
                          style: FontPalette.lightblack13600,
                        ),
                      ),
                    ],
                  ),
                  60.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          double width = constraints.maxWidth * .1399;
                          return Column(
                            children: [
                              // Pinput(
                              //    androidSmsAutofillMethod:
                              //       AndroidSmsAutofillMethod.smsUserConsentApi,
                              //   autofocus: true,
                              //   length: 4,
                              //   defaultPinTheme: defaultTheme(width),
                              //   focusedPinTheme: defaultTheme(width)
                              //       .copyDecorationWith(
                              //           border: Border.all(
                              //               color: HexColor('#EAF4F6'))),
                              //   errorPinTheme: defaultTheme(width)
                              //       .copyDecorationWith(
                              //           border: Border.all(
                              //               color: HexColor('#E50019'))),
                              //   submittedPinTheme: defaultTheme(width),
                              //   pinputAutovalidateMode:
                              //       PinputAutovalidateMode.onSubmit,
                              //   showCursor: true,
                              //   onCompleted: (value) {
                              //     otp = value;
                              //   },
                              //   inputFormatters: Validator.inputFormatter(
                              //           InputFormatType.phoneNumber) ??
                              //       [],
                              // ),
                              Pinput(
                                autofocus: true,
                                length: 4,
                                defaultPinTheme: defaultTheme(width),
                                focusedPinTheme: defaultTheme(width).copyDecorationWith(
                                  border: Border.all(color: HexColor('#EAF4F6')),
                                ),
                                errorPinTheme: defaultTheme(width).copyDecorationWith(
                                  border: Border.all(color: HexColor('#E50019')),
                                ),
                                submittedPinTheme: defaultTheme(width),
                                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                onCompleted: (value) {
                                  otp = value;
                                },
                                inputFormatters:
                                    Validator.inputFormatter(InputFormatType.phoneNumber) ?? [],
                              )
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                  25.verticalSpace,
                  CountDown(
                    seconds: 60,
                    currentMicroSeconds: _currentMicroSeconds,
                    onTap: () async {
                      // await services.resendOtp(phone: AuthServices.mob);
                    },
                  ),
                  10.verticalSpace,
                ],
              ).horizontalPadding(15.w),
              CustomButton(
                color: HexColor("569DAA"),
                text: "Send",
                isLoading: isLoading,
                onTap: () async {
                  // if (isLoading.value) return;
                  // isLoading.value = true;
                  // final res = await services
                  //     .verifyOtp(phone: widget.phone, otp: otp)
                  //     .catchError((error) {
                  //   isLoading.value = false;
                  //   return false;
                  // });
                  // isLoading.value = false;
                  // if (res ?? false) {
                  //   if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const HomeScreen()),
                      (Route<dynamic> route) => false);
                  // }
                },
              ).symmetricPadding(vertical: 44.h, horizontal: 15.w)
            ],
          ),
        ),
      ),
    );
  }
}
