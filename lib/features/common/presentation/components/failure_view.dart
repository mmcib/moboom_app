import 'package:flutter/material.dart';
import 'package:moboom_app/core/error/failures.dart';

class FailureView extends StatelessWidget {
  const FailureView({
    Key? key,
    required this.failure,
  }) : super(key: key);

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Failure message',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 12),
          Text(
            failure.getMessage(),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}