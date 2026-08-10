import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool isLoading;
  final bool expanded;
  const AppButton({
    super.key,
    required this.title,
    required this.onPress,
    this.isLoading = false,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: expanded ? MediaQuery.sizeOf(context).width : null,
          child: ElevatedButton(
            child: Text(title),
            onPressed: isLoading ? null : onPress,
          ),
        ),
        if (isLoading)
          CircularProgressIndicator(
            constraints: BoxConstraints.tight(Size(30, 30)),
          ),
      ],
    );
  }
}
