import 'package:flutter/material.dart';

class UniversalValidator extends StatelessWidget {
  final bool isValid;
  final Widget child;
  final String errorMessage;
  final double? paddingLeftErrorText;

  const UniversalValidator({
    super.key,
    required this.isValid,
    required this.child,
    required this.errorMessage,
    this.paddingLeftErrorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        if (!isValid)
          Padding(
            padding: EdgeInsets.only(top: 8.0, left: paddingLeftErrorText ?? 0),
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12.0,
              ),
            ),
          ),
      ],
    );
  }
}
