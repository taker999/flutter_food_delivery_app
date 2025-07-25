import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonColor,
    this.text,
    this.label,
    this.textColor,
    this.onPressed, this.icon,
  });

  final Color buttonColor;
  final String? text;
  final Widget? label;
  final Color? textColor;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label:
            label == null
                ? Text(
                  text ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                )
                : label!,
      ),
    );
  }
}
