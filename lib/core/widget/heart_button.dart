import 'package:flutter/material.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';

class HeartButton extends StatelessWidget {
  final bool isFavourite;
  final VoidCallback onTap;

  const HeartButton({
    super.key,
    required this.isFavourite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: ColorManager.white,
        elevation: 5,
        shape: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ImageIcon(
            AssetImage(
              isFavourite
                  ? IconsAssets.icClickedHeart
                  : IconsAssets.icHeart,
            ),
            color: ColorManager.primary,
          ),
        ),
      ),
    );
  }
}