import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import 'custom_card.dart';

class YVLabRow extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String tierText;
  final bool isPremium;
  final String title;
  final String level;
  final String duration;
  final String buildersCount;
  final VoidCallback onStartLab;

  const YVLabRow({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.tierText,
    this.isPremium = false,
    required this.title,
    required this.level,
    required this.duration,
    required this.buildersCount,
    required this.onStartLab,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.bananiCard,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: AppColors.bananiBorder,
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.bananiInk.withValues(alpha: 0.06),
          blurRadius: 28.0,
          offset: const Offset(0, 10.0),
          spreadRadius: 0,
        ),
      ],
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Thumbnail + Lab Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 84x84 Rounded thumbnail with graceful fallback
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 84.0,
                    height: 84.0,
                    color: AppColors.bananiLavender,
                    child: Image.network(
                      imageUrl,
                      width: 84.0,
                      height: 84.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 84.0,
                          height: 84.0,
                          color: AppColors.bananiLavender,
                          child: Icon(
                            isPremium
                                ? Icons.fingerprint_rounded
                                : Icons.auto_stories_rounded,
                            color: AppColors.bananiPrimary,
                            size: 32.0,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),

                // Content Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badges: Category pill + Free / Premium badge
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.bananiLavender,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              category,
                              style: const TextStyle(
                                color: AppColors.bananiPrimary,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (isPremium)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.workspace_premium_rounded,
                                  color: AppColors.bananiAccent,
                                  size: 13.0,
                                ),
                                SizedBox(width: 3.0),
                                Text(
                                  'Premium',
                                  style: TextStyle(
                                    color: AppColors.bananiAccent,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          else
                            Text(
                              tierText,
                              style: const TextStyle(
                                color: AppColors.bananiSuccess,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6.0),

                      // Title
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.bananiInk,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6.0),

                      // Meta details: Level • Duration • Builders
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              level,
                              style: const TextStyle(
                                color: AppColors.bananiSlate,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            _buildDotSeparator(),
                            Text(
                              duration,
                              style: const TextStyle(
                                color: AppColors.bananiSlate,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            _buildDotSeparator(),
                            const Icon(
                              Icons.people_outline_rounded,
                              color: AppColors.bananiSlate,
                              size: 13.0,
                            ),
                            const SizedBox(width: 3.0),
                            Text(
                              buildersCount,
                              style: const TextStyle(
                                color: AppColors.bananiSlate,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Button: Start Lab
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 46.0,
              child: OutlinedButton(
                onPressed: onStartLab,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppColors.bananiPrimary.withValues(alpha: 0.4),
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: AppColors.bananiCard,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Start Lab',
                      style: TextStyle(
                        color: AppColors.bananiPrimary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.bananiPrimary,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        width: 3.0,
        height: 3.0,
        decoration: const BoxDecoration(
          color: AppColors.bananiBorder,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
