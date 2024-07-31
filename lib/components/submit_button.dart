import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onTap,
    this.child,
    this.text,
  });

  final void Function() onTap;
  final Widget? child;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 200,
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: child ??
              Text(
                text!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
        ),
      ),
    );
  }
}
