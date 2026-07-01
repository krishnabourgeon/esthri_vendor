import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_button.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_tertformfield.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:elaveoironing_vendor/utils/helper/validator.dart';
import 'package:elaveoironing_vendor/view/home/homescreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // final services = GetIt.instance<AuthServices>();

  final ValueNotifier<bool> showKeyBoard = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(true);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    // final model = context.read<HomeProvider>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      20.verticalSpace,
                      Text(
                        "Create Account",
                        textAlign: TextAlign.center,
                        style: FontPalette.black29600,
                      ),
                      Text(
                        "Please enter your details",
                        style: FontPalette.black13400,
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "Name",
                            style: FontPalette.lightblack14500,
                          ),
                        ],
                      ),
                      3.verticalSpace,
                      CustomText(
                        semanticlabel: "Enter your phone number",
                        controller: nameController,
                        // prefixWidget: Assets.pngPhone,
                        // decoration: ConstantStyle.authTextFieldStyle,
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        // keyboardType: TextInputType.number,

                        // hintText: Constants.phoneNo,
                        // hintStyle: FontPalette.darkGrey11Medium,
                        style: FontPalette.lightblack14500,
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "Mobile number",
                            style: FontPalette.lightblack14500,
                          ),
                        ],
                      ),
                      3.verticalSpace,
                      CustomText(
                        semanticlabel: "Enter your phone number",
                        controller: phoneController,
                        // prefixWidget: Assets.pngPhone,
                        // decoration: ConstantStyle.authTextFieldStyle,
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        keyboardType: TextInputType.number,
                        inputFormatters: Validator.inputFormatter(
                                InputFormatType.phoneNumber) ??
                            [],
                        // hintText: Constants.phoneNo,
                        // hintStyle: FontPalette.darkGrey11Medium,
                        style: FontPalette.f00C159_9Medium,
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "Password",
                            style: FontPalette.lightblack14500,
                          ),
                        ],
                      ),
                      3.verticalSpace,
                      ValueListenableBuilder<bool>(
                          valueListenable: showPassword,
                          builder: (context, value, child) {
                            return CustomText(
                              semanticlabel: "Enter your password",
                              controller: passwordController,
                              // prefixWidget: Assets.pngChangePassword,
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
                              // hintText: Constants.password,
                              // hintStyle: FontPalette.darkGrey11Medium,
                              style: FontPalette.black12600,
                              obscureText: value,
                            );
                          }),
                      8.verticalSpace,
                    ],
                  ),
                ).horizontalPadding(25.w),
              ),
              Column(
                children: [
                  5.verticalSpace,
                  CustomButton(
                      color: HexColor("569DAA"),
                      isLoading: isLoading,
                      text: "Register",
                      onTap: () async {
                        //   String? phone = phoneController.text;
                        //   SharedPreferences prefs =
                        //       await SharedPreferences.getInstance();
                        //   String? devicetoken =
                        //       prefs.getString("devicetoken");
                        //   RegExp emailRegExp = RegExp(
                        //       r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                        //   String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        //   RegExp regExp = RegExp(pattern);
                        //   if (isLoading.value) return;

                        //   if (!regExp.hasMatch(phoneController.text)) {
                        //     return Helpers.showToast(
                        //         'Please enter valid mobile number');
                        //   }
                        //   if (!emailRegExp.hasMatch(emailController.text)) {
                        //     return Helpers.showToast(
                        //         'Please enter valid Email address');
                        //   }
                        //   if (isLoading.value) return;
                        //   isLoading.value = true;
                        //   FocusScope.of(context).unfocus();
                        //   final res = await services
                        //       .register(
                        //           name: nameController.text,
                        //           email: emailController.text,
                        //           phone: phoneController.text,
                        //           password: passwordController.text,
                        //           address: addressController.text,
                        //           latitude:
                        //               model.deviceposition?.latitude ??
                        //                   8.52,
                        //           longitude:
                        //               model.deviceposition?.longitude ??
                        //                   11.222,
                        //           devicetoken: '54321')
                        //       .catchError((error) {
                        //     isLoading.value = false;
                        //     return false;
                        //   });
                        //   isLoading.value = false;
                        //   if (res ?? false) {
                        //     if (!mounted) return;
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) =>
                        //           VerificationScreen(phone: phone),
                        //     ));
                        //   }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomeScreen()),
                            (Route<dynamic> route) => false);
                      }),
                  50.verticalSpace,
                  ValueListenableBuilder<bool>(
                      valueListenable: showKeyBoard,
                      builder: (context, value, child) {
                        return value
                            ? const SizedBox.shrink()
                            : Column(children: [
                                28.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: FontPalette.black13500,
                                    ).rightPadding(7.w),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                      child: Text(
                                        "Log in",
                                        style: FontPalette.blue13500,
                                      ),
                                    ),
                                  ],
                                ),
                                10.verticalSpace,
                              ]);
                      }),
                ],
              ).horizontalPadding(25.w),
            ],
          ).verticalPadding(20.h),
        ),
      ),
    );
  }
}
