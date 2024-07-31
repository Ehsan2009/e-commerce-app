import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.onPressed,
    this.title,
    required this.text,
    this.icon,
    required this.padding,
    required this.enableIcon,
  });

  final void Function()? onPressed;
  final String? title;
  final String text;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final bool enableIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: enableIcon
            ? Row(
                children: [
                  Icon(
                    icon,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )
            : Row(
                children: [
                  Icon(
                    icon,
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? '',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
