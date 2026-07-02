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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36.r),
                    bottomRight: Radius.circular(36.r),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      30.verticalSpace,
                      Container(
                        height: 78.w,
                        width: 78.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryDark.withValues(
                                alpha: 0.25,
                              ),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.iron_outlined,
                          color: AppColors.primaryDark,
                          size: 38.w,
                        ),
                      ),
                      18.verticalSpace,
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 26.sp,
                          color: Colors.white,
                        ),
                      ),
                      6.verticalSpace,
                      Text(
                        "Sign in to manage your ironing orders",
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                      ),
                      30.verticalSpace,
                    ],
                  ),
                ),
              ),
              40.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Text("Phone Number", style: FontPalette.black13500),
                    ],
                  ),
                  8.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryLight),
                      borderRadius: BorderRadius.circular(11.r),
                    ),
                    height: 47.h,
                    child: TextField(
                      cursorColor: AppColors.primaryDark,
                      style: FontPalette.black15500,
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "Password",
                        style: FontPalette.black13500,
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  ValueListenableBuilder<bool>(
                      valueListenable: showPassword,
                      builder: (context, value, child) {
                        return CustomText(
                          cursorColor: AppColors.primaryDark,
                          style: FontPalette.black15500,
                          semanticlabel: "Enter your password",
                          controller: passwordController,
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
                          obscureText: value,
                        );
                      }),
                  50.verticalSpace,
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
                    fontStyle: FontPalette.white14500,
                  ),
                  30.verticalSpace,
                ],
              ).horizontalPadding(24.w),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
