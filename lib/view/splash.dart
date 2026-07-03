// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:provider/provider.dart';
// // import 'package:elaveoironing_vendor/homeprovider.dart';
// // import 'package:elaveoironing_vendor/res/app_config.dart';
// // import 'package:elaveoironing_vendor/services/network/api_request.dart';
// // import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
// // import 'package:elaveoironing_vendor/view/authscreens/loginpage.dart';
// // import 'package:elaveoironing_vendor/view/home/homescreen.dart';

// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});

// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen> {
// //   @override
// //   void initState() {
// //     Future.delayed(
// //       Duration(milliseconds: 5000),
// //       () => checktoken(),
// //     );
// //     super.initState();
// //   }

// //   checktoken() async {
// //     final home = context.read<HomeProvider>();

// //     final authToken = await sharedPrefs.getAuthToken();
// //     AppConfig.isactive = await sharedPrefs.getactive();

// //     print(authToken);

// //     if (authToken != null) {
// //       AppConfig.authToken = authToken;
// //       print(AppConfig.authToken);
// //       AppConfig.settings = await sharedPrefs.getsettings();
// //       await home.getversion();
// //       await home.getcount();
// //       await home.getprofile();
// //       Navigator.of(context).pushReplacement(MaterialPageRoute(
// //         builder: (context) => HomeScreen(),
// //       ));
// //       AppConfig.name = await sharedPrefs.getphone();
// //       final id = await sharedPrefs.getid();
// //       AppConfig.id = id;
// //     } else {
// //       Navigator.of(context).pushReplacement(MaterialPageRoute(
// //         builder: (context) => LoginScreen(),
// //       ));
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Container(
// //               height: 60.h,
// //               width: 249.w,
// //               decoration: BoxDecoration(
// //                   image: DecorationImage(
// //                       image: AssetImage("assets/esthri_splash.png"),
// //                       fit: BoxFit.contain)),
// //             ),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.end,
// //               children: [
// //                 Text("Partner"),
// //               ],
// //             ).rightPadding(60.w)
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }






// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:elaveoironing_vendor/homeprovider.dart';
// import 'package:elaveoironing_vendor/res/app_config.dart';
// import 'package:elaveoironing_vendor/services/network/api_request.dart';
// import 'package:elaveoironing_vendor/utils/helper/extensions.dart';
// import 'package:elaveoironing_vendor/view/authscreens/loginpage.dart';
// import 'package:elaveoironing_vendor/view/home/homescreen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   // Blue accent to match the vendor brand palette.
//   static const Color _accent = Color(0xFF7692C2);
//   static const Color _accentDeep = Color(0xFF1B365D);

//   // One-shot entrance animation
//   late final AnimationController _entryController;
//   // Slow continuous ambient motion (background tint + glow orbs)
//   late final AnimationController _ambientController;
//   // Gentle float for the logo once settled
//   late final AnimationController _floatController;
//   // One-time shimmer sweep across the logo
//   late final AnimationController _shimmerController;
//   // Soft pulsing dot loader
//   late final AnimationController _dotsController;

//   late final Animation<double> _cardFade;
//   late final Animation<double> _cardScale;
//   late final Animation<double> _logoFade;
//   late final Animation<double> _logoScale;
//   late final Animation<double> _labelFade;
//   late final Animation<Offset> _labelSlide;
//   late final Animation<double> _dividerWidth;
//   late final Animation<double> _loaderFade;
//   late final Animation<double> _floatAnim;

//   @override
//   void initState() {
//     super.initState();

//     _entryController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );

//     // Soft card behind the logo appears first
//     _cardFade = CurvedAnimation(
//       parent: _entryController,
//       curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
//     );
//     _cardScale = Tween<double>(begin: 0.88, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _entryController,
//         curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
//       ),
//     );

//     // Logo fades/scales in slightly after the card
//     _logoFade = CurvedAnimation(
//       parent: _entryController,
//       curve: const Interval(0.15, 0.6, curve: Curves.easeOut),
//     );
//     _logoScale = Tween<double>(begin: 0.92, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _entryController,
//         curve: const Interval(0.15, 0.65, curve: Curves.easeOutCubic),
//       ),
//     );

//     // "Partner" label + divider follow after the logo
//     _labelFade = CurvedAnimation(
//       parent: _entryController,
//       curve: const Interval(0.5, 0.85, curve: Curves.easeOut),
//     );
//     _labelSlide = Tween<Offset>(
//       begin: const Offset(0, 0.25),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: _entryController,
//         curve: const Interval(0.5, 0.85, curve: Curves.easeOut),
//       ),
//     );
//     _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _entryController,
//         curve: const Interval(0.55, 0.9, curve: Curves.easeOutCubic),
//       ),
//     );

//     // Loader fades in last
//     _loaderFade = CurvedAnimation(
//       parent: _entryController,
//       curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
//     );

//     _entryController.forward();

//     // Ambient background motion — slow, continuous, never jarring
//     _ambientController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 8),
//     )..repeat();

//     // Gentle logo float once it has landed
//     _floatController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 3000),
//     )..repeat(reverse: true);
//     _floatAnim = Tween<double>(begin: -4, end: 4).animate(
//       CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
//     );

//     // Single shimmer sweep, once, after the logo has mostly appeared
//     _shimmerController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//     Future.delayed(const Duration(milliseconds: 900), () {
//       if (mounted) _shimmerController.forward();
//     });

//     // Soft pulsing dots for the loader
//     _dotsController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1400),
//     )..repeat();

//     Future.delayed(
//       const Duration(milliseconds: 5000),
//       () => checktoken(),
//     );
//   }

//   @override
//   void dispose() {
//     _entryController.dispose();
//     _ambientController.dispose();
//     _floatController.dispose();
//     _shimmerController.dispose();
//     _dotsController.dispose();
//     super.dispose();
//   }

//   checktoken() async {
//     final home = context.read<HomeProvider>();

//     final authToken = await sharedPrefs.getAuthToken();
//     AppConfig.isactive = await sharedPrefs.getactive();

//     print(authToken);

//     if (authToken != null) {
//       AppConfig.authToken = authToken;
//       print(AppConfig.authToken);
//       AppConfig.settings = await sharedPrefs.getsettings();
//       await home.getversion();
//       await home.getcount();
//       await home.getprofile();
//       if (!mounted) return;
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (context) => HomeScreen(),
//       ));
//       AppConfig.name = await sharedPrefs.getphone();
//       final id = await sharedPrefs.getid();
//       AppConfig.id = id;
//     } else {
//       if (!mounted) return;
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (context) => LoginScreen(),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: AnimatedBuilder(
//         animation: Listenable.merge([
//           _entryController,
//           _ambientController,
//           _floatController,
//           _shimmerController,
//           _dotsController,
//         ]),
//         builder: (context, child) {
//           final ambient = _ambientController.value; // 0..1 loop

//           return Stack(
//             children: [
//               // Very soft blue gradient wash, breathing slowly
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment(
//                       -1 + 0.15 * math.sin(ambient * 2 * math.pi),
//                       -1,
//                     ),
//                     end: Alignment(
//                       1 - 0.15 * math.sin(ambient * 2 * math.pi),
//                       1,
//                     ),
//                     colors: [
//                       Colors.white,
//                       _accent.withValues(alpha: 0.05),
//                       Colors.white,
//                     ],
//                   ),
//                 ),
//               ),

//               // Drifting blue glow orbs for depth
//               Positioned(
//                 top: -60.w + 18.w * math.sin(ambient * 2 * math.pi),
//                 right: -50.w + 14.w * math.cos(ambient * 2 * math.pi),
//                 child: _glowCircle(190.w, _accent.withValues(alpha: 0.06)),
//               ),
//               Positioned(
//                 bottom: -50.w + 16.w * math.cos(ambient * 2 * math.pi),
//                 left: -60.w + 14.w * math.sin(ambient * 2 * math.pi),
//                 child: _glowCircle(220.w, _accentDeep.withValues(alpha: 0.05)),
//               ),

//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Logo with soft card behind it + float + shimmer
//                     Transform.translate(
//                       offset: Offset(0, _floatAnim.value),
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           // Soft elevated card
//                           FadeTransition(
//                             opacity: _cardFade,
//                             child: ScaleTransition(
//                               scale: _cardScale,
//                               child: Container(
//                                 width: 210.w,
//                                 height: 130.h,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(28.r),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: _accent.withValues(alpha: 0.12),
//                                       blurRadius: 34,
//                                       spreadRadius: 2,
//                                       offset: const Offset(0, 10),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),

//                           // Logo, fade + scale in, with a single shimmer sweep
//                           FadeTransition(
//                             opacity: _logoFade,
//                             child: ScaleTransition(
//                               scale: _logoScale,
//                               child: SizedBox(
//                                 height: 60.h,
//                                 width: 190.w,
//                                 child: ShaderMask(
//                                   blendMode: _shimmerController.value < 1
//                                       ? BlendMode.srcATop
//                                       : BlendMode.dst,
//                                   shaderCallback: (bounds) {
//                                     final t = _shimmerController.value;
//                                     return LinearGradient(
//                                       begin: Alignment(-1.5 + 3 * t, 0),
//                                       end: Alignment(-0.5 + 3 * t, 0),
//                                       colors: [
//                                         Colors.white.withValues(alpha: 0.0),
//                                         _accent.withValues(alpha: 0.25),
//                                         Colors.white.withValues(alpha: 0.0),
//                                       ],
//                                       stops: const [0.35, 0.5, 0.65],
//                                     ).createShader(bounds);
//                                   },
//                                   child: Image.asset(
//                                     "assets/esthri_splash.png",
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     SizedBox(height: 26.h),

//                     // "Partner" label with an animated underline reveal
//                     SlideTransition(
//                       position: _labelSlide,
//                       child: FadeTransition(
//                         opacity: _labelFade,
//                         child: Column(
//                           children: [
//                             Text(
//                               "PARTNER",
//                               style: TextStyle(
//                                 color: _accentDeep,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 4.0,
//                               ),
//                             ),
//                             SizedBox(height: 8.h),
//                             AnimatedBuilder(
//                               animation: _dividerWidth,
//                               builder: (context, _) {
//                                 return Container(
//                                   height: 2,
//                                   width: 36.w * _dividerWidth.value,
//                                   decoration: BoxDecoration(
//                                     color: _accent.withValues(alpha: 0.6),
//                                     borderRadius: BorderRadius.circular(2),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: 60.h),

//                     // Minimal pulsing dot loader
//                     FadeTransition(
//                       opacity: _loaderFade,
//                       child: _PulsingDots(
//                         controller: _dotsController,
//                         color: _accent,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _glowCircle(double size, Color color) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: color,
//       ),
//     );
//   }
// }

// /// Three soft dots that pulse in sequence — a quiet loading cue
// /// that fits the light, premium look of the splash.
// class _PulsingDots extends StatelessWidget {
//   final AnimationController controller;
//   final Color color;
//   const _PulsingDots({required this.controller, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(3, (i) {
//         return AnimatedBuilder(
//           animation: controller,
//           builder: (context, _) {
//             final t = (controller.value - (i * 0.2)) % 1.0;
//             final scale = 0.6 + 0.4 * (0.5 - (t - 0.5).abs()) * 2;
//             final opacity = 0.35 + 0.55 * (0.5 - (t - 0.5).abs()) * 2;
//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 4.w),
//               child: Transform.scale(
//                 scale: scale.clamp(0.6, 1.0),
//                 child: Container(
//                   width: 8.w,
//                   height: 8.w,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: color.withValues(
//                       alpha: opacity.clamp(0.35, 0.9),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }





import 'dart:math' as math;
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

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Blue accent to match the vendor brand palette.
  static const Color _accent = Color(0xFF7692C2);
  static const Color _accentDeep = Color(0xFF1B365D);

  // One-shot entrance animation
  late final AnimationController _entryController;
  // Slow continuous ambient motion (background tint + glow orbs)
  late final AnimationController _ambientController;
  // Gentle float for the logo once settled
  late final AnimationController _floatController;
  // One-time shimmer sweep across the logo
  late final AnimationController _shimmerController;
  // Soft pulsing dot loader
  late final AnimationController _dotsController;

  late final Animation<double> _cardFade;
  late final Animation<double> _cardScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _labelFade;
  late final Animation<Offset> _labelSlide;
  late final Animation<double> _dividerWidth;
  late final Animation<double> _loaderFade;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Soft card behind the logo appears first
    _cardFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );
    _cardScale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    // Logo fades/scales in slightly after the card
    _logoFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.15, 0.6, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.15, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    // "Partner" label + divider follow after the logo
    _labelFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.5, 0.85, curve: Curves.easeOut),
    );
    _labelSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOut),
      ),
    );
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.55, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    // Loader fades in last
    _loaderFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
    );

    _entryController.forward();

    // Ambient background motion — slow, continuous, never jarring
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // Gentle logo float once it has landed
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Single shimmer sweep, once, after the logo has mostly appeared
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) _shimmerController.forward();
    });

    // Soft pulsing dots for the loader
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    Future.delayed(
      const Duration(milliseconds: 5000),
      () => checktoken(),
    );
  }

  @override
  void dispose() {
    _entryController.dispose();
    _ambientController.dispose();
    _floatController.dispose();
    _shimmerController.dispose();
    _dotsController.dispose();
    super.dispose();
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
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
      AppConfig.name = await sharedPrefs.getphone();
      final id = await sharedPrefs.getid();
      AppConfig.id = id;
    } else {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _entryController,
          _ambientController,
          _floatController,
          _shimmerController,
          _dotsController,
        ]),
        builder: (context, child) {
          final ambient = _ambientController.value; // 0..1 loop

          return Stack(
            children: [
              // Very soft blue gradient wash, breathing slowly
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(
                      -1 + 0.15 * math.sin(ambient * 2 * math.pi),
                      -1,
                    ),
                    end: Alignment(
                      1 - 0.15 * math.sin(ambient * 2 * math.pi),
                      1,
                    ),
                    colors: [
                      Colors.white,
                      _accent.withValues(alpha: 0.05),
                      Colors.white,
                    ],
                  ),
                ),
              ),

              // Drifting blue glow orbs for depth
              Positioned(
                top: -60.w + 18.w * math.sin(ambient * 2 * math.pi),
                right: -50.w + 14.w * math.cos(ambient * 2 * math.pi),
                child: _glowCircle(190.w, _accent.withValues(alpha: 0.06)),
              ),
              Positioned(
                bottom: -50.w + 16.w * math.cos(ambient * 2 * math.pi),
                left: -60.w + 14.w * math.sin(ambient * 2 * math.pi),
                child: _glowCircle(220.w, _accentDeep.withValues(alpha: 0.05)),
              ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo with soft card behind it + float + shimmer
                    Transform.translate(
                      offset: Offset(0, _floatAnim.value),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Soft elevated circular card
                          FadeTransition(
                            opacity: _cardFade,
                            child: ScaleTransition(
                              scale: _cardScale,
                              child: Container(
                                width: 190.w,
                                height: 190.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: _accent.withValues(alpha: 0.12),
                                      blurRadius: 34,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Logo, fade + scale in, with a single shimmer sweep
                          FadeTransition(
                            opacity: _logoFade,
                            child: ScaleTransition(
                              scale: _logoScale,
                              child: SizedBox(
                                height: 60.h,
                                width: 140.w,
                                child: ShaderMask(
                                  blendMode: _shimmerController.value < 1
                                      ? BlendMode.srcATop
                                      : BlendMode.dst,
                                  shaderCallback: (bounds) {
                                    final t = _shimmerController.value;
                                    return LinearGradient(
                                      begin: Alignment(-1.5 + 3 * t, 0),
                                      end: Alignment(-0.5 + 3 * t, 0),
                                      colors: [
                                        Colors.white.withValues(alpha: 0.0),
                                        _accent.withValues(alpha: 0.25),
                                        Colors.white.withValues(alpha: 0.0),
                                      ],
                                      stops: const [0.35, 0.5, 0.65],
                                    ).createShader(bounds);
                                  },
                                  child: Image.asset(
                                    "assets/esthri_splash.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 26.h),

                    // "Partner" label with an animated underline reveal
                    SlideTransition(
                      position: _labelSlide,
                      child: FadeTransition(
                        opacity: _labelFade,
                        child: Column(
                          children: [
                            Text(
                              "PARTNER",
                              style: TextStyle(
                                color: _accentDeep,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 4.0,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            AnimatedBuilder(
                              animation: _dividerWidth,
                              builder: (context, _) {
                                return Container(
                                  height: 2,
                                  width: 36.w * _dividerWidth.value,
                                  decoration: BoxDecoration(
                                    color: _accent.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 60.h),

                    // Minimal pulsing dot loader
                    FadeTransition(
                      opacity: _loaderFade,
                      child: _PulsingDots(
                        controller: _dotsController,
                        color: _accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _glowCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

/// Three soft dots that pulse in sequence — a quiet loading cue
/// that fits the light, premium look of the splash.
class _PulsingDots extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  const _PulsingDots({required this.controller, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final t = (controller.value - (i * 0.2)) % 1.0;
            final scale = 0.6 + 0.4 * (0.5 - (t - 0.5).abs()) * 2;
            final opacity = 0.35 + 0.55 * (0.5 - (t - 0.5).abs()) * 2;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Transform.scale(
                scale: scale.clamp(0.6, 1.0),
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(
                      alpha: opacity.clamp(0.35, 0.9),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}