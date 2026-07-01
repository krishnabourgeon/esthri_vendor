import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/authentication/auth_service.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_button.dart';
import 'package:elaveoironing_vendor/utils/common_widgets/custom_tertformfield.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:elaveoironing_vendor/utils/helper/helpers.dart';
import 'package:elaveoironing_vendor/view/home/homescreen.dart';
import 'package:elaveoironing_vendor/viewmodel.dart/homeservice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> showKeyBoard = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(true);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final services = GetIt.instance<AuthServices>();
  final homeservices = GetIt.instance<HomeServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 20.verticalSpace,
              Container(
                // height: 300.h,
                child: Column(
                  children: [
                    //  40.verticalSpace,
                    // Container(
                    //   height: 250.h,
                    //   width: 300.w,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: AssetImage("assets/logo_no_bg.png"),
                    //           fit: BoxFit.contain)),
                    // ),

                    Text(
                      "Welcome Back",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 29.sp,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ).horizontalPadding(0.w),
                    Text(
                      "Please enter your details",
                      style: GoogleFonts.inter(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp),
                    ),
                    40.verticalSpace,
                    const Row(
                      children: [],
                    ).horizontalPadding(12.w),
                    25.verticalSpace,
                    Row(
                      children: [
                        Text("Phone Number", style: FontPalette.black13500),
                      ],
                    ),
                    5.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color.fromRGBO(23, 122, 99, 1)),
                          //color: const Color.fromRGBO(234, 244, 246, 1),
                          borderRadius: BorderRadius.circular(10.r)),
                      width: 348.w,
                      height: 47.h,
                      child: TextField(
                        cursorColor: Colors.black,
                        style: FontPalette.black15500,

                        // style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 14.sp,
                        //     fontWeight: FontWeight.w500),
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.w),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        Text(
                          "Password",
                          style: FontPalette.black13500,
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    ValueListenableBuilder<bool>(
                        valueListenable: showPassword,
                        builder: (context, value, child) {
                          return CustomText(
                            cursorColor: Colors.black,

                            style: FontPalette.black15500,
                            semanticlabel: "Enter your password",
                            controller: passwordController,
                            maxlines: 1,
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

                            obscureText: value,
                          );
                        }),
                    120.verticalSpace,
                    CustomButton(
                      onTap: () async {
                        final home = context.read<HomeProvider>();
                        if (phoneController.text.length != 10) {
                          Helpers.showToast("Eneter a valid mobile number");
                        } else {
                          if (passwordController.text.length < 8) {
                            Helpers.showToast("Password must be 8 charachters");
                          } else {
                            String phone = phoneController.text;
                            String pass = passwordController.text;
                            isLoading.value = true;
                            FocusScope.of(context).unfocus();
                            final res = await services
                                .logIn(phone: phone, password: pass)
                                .catchError((error) {
                              Helpers.showToast(error);
                              isLoading.value = false;
                              return error;
                            });

                            if (res ?? false) {
                              await home.getversion();
                              await home.getcount();
                              await home.getprofile();
                              await homeservices.updateactive(status: 1);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false);
                              isLoading.value = false;
                            } else {
                              isLoading.value = false;
                            }
                          }
                        }
                      },
                      text: "Log in",
                      isLoading: isLoading,
                      // color: Color.fromRGBO(23, 122, 99, 1),
                      fontStyle: FontPalette.white14500,
                    ),
                    // 120.verticalSpace,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "If you don’t have account ?",
                    //       style: GoogleFonts.inter(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 13.sp,
                    //           color: const Color.fromRGBO(0, 0, 0, 1)),
                    //     ),
                    //     InkWell(
                    //       onTap: () =>
                    //           Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => const SignupScreen(),
                    //       )),
                    //       child: Text(
                    //         "Register",
                    //         style: GoogleFonts.inter(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 13.sp,
                    //             color: const Color.fromRGBO(0, 0, 0, 1)),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),

              //80.verticalSpace,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text("If you don’t have account ?",
              //         style: GoogleFonts.inter(
              //             fontWeight: FontWeight.w400,
              //             fontSize: 13.sp,
              //             color: Color.fromRGBO(0, 0, 0, 1))),
              //     Text("Register",
              //         style: GoogleFonts.inter(
              //             fontWeight: FontWeight.w400,
              //             fontSize: 13.sp,
              //             color: Color.fromRGBO(0, 0, 0, 1))
              //             )
              //   ],
              // )
            ],
          ).horizontalPadding(20.w),
        ),
      ),
    );
  }
}
