import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moboom_app/core/presentation/components/button_component.dart';
import 'package:moboom_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:moboom_app/features/auth/presentation/pages/sign_up_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleButton(
              text: 'Logowanie',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SignInPage(),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            SimpleButton(
              text: 'Rejestracja',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SignUpPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
