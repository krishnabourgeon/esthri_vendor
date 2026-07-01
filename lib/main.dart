import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:elaveoironing_vendor/authentication/auth_service.dart';
import 'package:elaveoironing_vendor/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elaveoironing_vendor/services/shared_prefernce/shared_prefs.dart';
import 'package:elaveoironing_vendor/view/splash.dart';
import 'package:elaveoironing_vendor/viewmodel.dart/homeservice.dart';
import 'services/network/base_services.dart';
import 'services/network/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  setUp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

void setUp() async {
  GetIt.instance.registerSingleton<BaseServices>(Services());
  GetIt.instance.registerSingleton<SharedPrefs>(SharedPrefs());
  GetIt.instance.registerFactory<AuthServices>(() => AuthServices());
  GetIt.instance.registerFactory<HomeServices>(() => HomeServices());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => HomeProvider()),
            ],
            child: MaterialApp(
              title: 'Elaveo_Shopkeeper',
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: SplashScreen(),
            ),
          );
        });
  }
}
