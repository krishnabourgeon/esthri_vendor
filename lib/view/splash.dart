import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:elaveoironing_vendor/res/app_config.dart';
import 'package:elaveoironing_vendor/services/network/api_request.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
import 'package:elaveoironing_vendor/view/authscreens/loginpage.dart';
import 'package:elaveoironing_vendor/view/home/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(milliseconds: 5000),
      () => checktoken(),
    );
    super.initState();
  }

  checktoken() async {
    final home = context.read<HomeProvider>();

    final authToken = await sharedPrefs.getAuthToken();
    AppConfig.isactive = await sharedPrefs.getactive();

    print(authToken);

    if (authToken != null) {
      AppConfig.authToken = authToken;
      print(AppConfig.authToken);
      AppConfig.settings = await sharedPrefs.getsettings();
      await home.getversion();
      await home.getcount();
      await home.getprofile();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
      AppConfig.name = await sharedPrefs.getphone();
      final id = await sharedPrefs.getid();
      AppConfig.id = id;
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60.h,
              width: 249.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Untitled-2 1.png"),
                      fit: BoxFit.contain)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Partner"),
              ],
            ).rightPadding(60.w)
          ],
        ),
      ),
    );
  }
}
