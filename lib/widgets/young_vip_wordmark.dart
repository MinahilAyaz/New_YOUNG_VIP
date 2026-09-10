import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class YoungVipWordmark extends StatelessWidget {
  const YoungVipWordmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        const Text(
          'YOUNG',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          'VIP',
          style: TextStyle(
            color: AppColors.youngVipGold,
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.5,
            height: 1.0,
            shadows: [
              Shadow(
                color: AppColors.youngVipGold.withValues(alpha: 0.35),
                offset: const Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
