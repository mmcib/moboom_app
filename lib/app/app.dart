import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moboom_app/core/theme/theme.dart';
import 'package:moboom_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'router.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.appName,
  }) : super(key: key);

  final String appName;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: appName,
          theme: getAppTheme(context),
          darkTheme: getAppTheme(context),
          initialRoute: '/initialPage',
          onGenerateRoute: (settings) => router(settings),
        );
      },
    );
  }
}
