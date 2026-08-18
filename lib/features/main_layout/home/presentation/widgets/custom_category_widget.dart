import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CustomCategoryWidget extends StatelessWidget {
  final String title;
  final String image;

  const CustomCategoryWidget({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            height: 90.h,
            width: 90.w,
            color: Colors.white,
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.contain, // أهم سطر
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
            ),
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

  // CachedNetworkImage(
        //   height: 100,
        //   width: 100,
        //   fit: BoxFit.cover,
        //   imageUrl: ImageAssets.categoryHomeImage,
        //   placeholder: (context, url) =>
        //       const Center(child: CircularProgressIndicator()),
        //   errorWidget: (context, url, error) =>
        //       const Center(child: Icon(Icons.error)),
        //   imageBuilder: (context, imageProvider) {
        //     return Container(
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         image: DecorationImage(
        //           image: imageProvider,
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     );
        //   },
        // ),