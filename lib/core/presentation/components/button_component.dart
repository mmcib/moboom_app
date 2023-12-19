import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    super.key,
    required this.text,
    this.textFontSize = 16,
    this.fixedSize,
    required this.onPressed,
  });

  final String text;
  final double? textFontSize;
  final MaterialStateProperty<Size>? fixedSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: textFontSize,
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
             EdgeInsets.all(16.r),
          ),
          fixedSize: fixedSize,
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.r),
              side: BorderSide(color: Colors.deepPurpleAccent),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
