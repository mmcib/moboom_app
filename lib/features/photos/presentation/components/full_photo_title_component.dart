import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moboom_app/core/extensions/string_extensions.dart';
import 'package:moboom_app/generated/l10n.dart';

class FullPhotoTitleComponent extends StatelessWidget {
  const FullPhotoTitleComponent({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: 1.sw,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 8,
          ).r,
          child: Column(
            children: [
              Text(
                S.of(context).title.capitalize(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}