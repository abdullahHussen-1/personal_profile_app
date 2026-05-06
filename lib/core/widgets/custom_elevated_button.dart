import 'package:flutter/material.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  String text;
  Color backGroundColor;
  double? widthContainer;
  double? heightContainer;
  bool checkIcon;
  Widget? child;

  // ignore: use_key_in_widget_constructors
  CustomElevatedButton({
    this.onPressed,
    required this.text,
    required this.backGroundColor,
    this.checkIcon = false,
    this.child,
    this.heightContainer,
    this.widthContainer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthContainer ?? double.infinity,
      child: checkIcon
          ? InkWell(
              onTap: onPressed,
              child: Container(
                width: widthContainer,
                height: heightContainer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: backGroundColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(child: child),
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backGroundColor,
                padding: EdgeInsets.symmetric(
                  vertical: AppMediaQuery.sizeHeight(context) * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
