import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBrandWidget extends StatelessWidget {
  final String image;
  final String name;

  const CustomBrandWidget({
    super.key,
    required this.image,
    required this.name,
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
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}