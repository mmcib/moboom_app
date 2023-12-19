import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moboom_app/core/presentation/components/button_component.dart';
import 'package:moboom_app/generated/l10n.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).more),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 1.sw,
          child: Column(
            children: [
              SimpleButton(
                text: S.of(context).logout,
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(1.sw, 70.h), // Setting the width and height of the button
                ),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/initialPage', (route) => false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
