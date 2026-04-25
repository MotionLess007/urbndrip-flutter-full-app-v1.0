import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final bool alignRight;
  final VoidCallback? onBack;

  const AppHeader({
    super.key,
    this.alignRight = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 🔙 Back button (optional)
          if (onBack != null)
            GestureDetector(
              onTap: onBack,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),

          if (alignRight) const Spacer(),

          // 🔥 LOGO
          const Text(
            "URBNDRIP",
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),

          if (!alignRight) const Spacer(), // center alignment
        ],
      ),
    );
  }
}