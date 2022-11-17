import 'package:al_baseet/src/screens/shared_widgets/app_nav.dart';
import 'package:flutter/material.dart';

class CustomRoundImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final bool imagePreview;
  final Color borderColor;
  CustomRoundImage(
      {@required this.imageUrl,
      this.height = 60,
      this.width = 60,
      this.imagePreview = false,
      this.borderColor = Colors.black45});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: imagePreview
          ? () {
              // appNavPush(context,
              //     page: ImagePreView(url: imageUrl, isFile: false));
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: .5, color: borderColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(width),
          child: FadeInImage.assetNetwork(
            image: imageUrl,
            placeholder: 'assets/png/logo.png',
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
