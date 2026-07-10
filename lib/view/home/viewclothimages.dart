import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elaveoironing_vendor/datamodel/pending_datamodel.dart';
import 'package:elaveoironing_vendor/res/font_palette.dart';
import 'package:elaveoironing_vendor/utils/helper/extensions.dart';

class Viewclothimages extends StatefulWidget {
  const Viewclothimages({
    super.key,
    this.image,
  });
  final List<OrderImages>? image;
  @override
  State<Viewclothimages> createState() => _ViewclothimagesState();
}

class _ViewclothimagesState extends State<Viewclothimages> {
  @override
  Widget build(BuildContext context) {
    void openBottomSheet({String? image}) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return InteractiveViewer(
            panEnabled: true, // Enable panning
            minScale: 1.0, // Minimum zoom scale
            maxScale: 4.0, // Maximum zoom scale
            child: Container(
              width: double.infinity,
              height: 600.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                      image: NetworkImage("$image"), 
                      fit: BoxFit.fill,
                      onError: (exception, stackTrace) {
                        debugPrint("Image error: $exception");
                      })),
            ).horizontalPadding(20.w),
          );
        },
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          //centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text(
            "Cloth Details",
            style: FontPalette.black23600,
          ),
        ),
        body: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 3 columns
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 1.0, // Aspect ratio of each image (width/height)
          ),
          itemCount: widget.image?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () =>
                  openBottomSheet(image: widget.image![index].filePath),
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
                  child: Image.network(
                    widget.image![index].filePath ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  )
                  // Image.asset(
                  //   "assets/shoe.png",
                  //   fit: BoxFit.contain,
                  // )
                  // Image.network(
                  //   imageUrls[index],
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            );
          },
        ).horizontalPadding(20.w)

        //  Column(
        //   children: [
        //     Row(
        //       children: [
        //         Container(
        //           height: 151.h,
        //           child: Image.asset("assets/logo.jpg"),
        //         ),
        //         Container(
        //           height: 151.h,
        //           child: Image.asset("assets/logo.jpg"),
        //         )
        //       ],
        //     )
        //   ],
        // ),
        );
  }
}
