import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/generated/l10n.dart';

class FailureView extends StatelessWidget {
  const FailureView({
    Key? key,
    required this.failure,
    this.onRetry,
  }) : super(key: key);

  final Failure failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32).r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).failureViewMessage,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 12.h),
          Text(
            failure.getMessage(),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: 12.h),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(S.of(context).tryAgain),
            ),
          ]
        ],
      ),
    );
  }
}
