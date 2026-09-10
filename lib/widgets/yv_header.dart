import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class YVHeader extends StatelessWidget {
  final VoidCallback? onOpenDrawer;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;
  final String avatarUrl;

  const YVHeader({
    super.key,
    this.onOpenDrawer,
    this.onNotificationTap,
    this.onAvatarTap,
    this.avatarUrl =
        'https://storage.googleapis.com/banani-avatars/avatar/female/25-35/European/3',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Menu Drawer Toggle + Brand Logo & Subtitle
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(
                  builder: (ctx) => GestureDetector(
                    onTap: onOpenDrawer ?? () => Scaffold.of(ctx).openDrawer(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 38.0,
                      height: 38.0,
                      decoration: BoxDecoration(
                        color: AppColors.bananiCard,
                        borderRadius: BorderRadius.circular(9.0),
                        border: Border.all(
                          color: AppColors.bananiBorder,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.bananiInk.withValues(alpha: 0.04),
                            blurRadius: 8.0,
                            offset: const Offset(0, 2.0),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.menu_rounded,
                        color: AppColors.bananiInk,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Flexible(
                  child: GestureDetector(
                    onTap: onOpenDrawer,
                    behavior: HitTestBehavior.opaque,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 38.0,
                            height: 38.0,
                            decoration: BoxDecoration(
                              color: AppColors.bananiPrimary,
                              borderRadius: BorderRadius.circular(9.0),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.bananiPrimary
                                      .withValues(alpha: 0.28),
                                  blurRadius: 8.0,
                                  offset: const Offset(0, 3.0),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'YV',
                              style: TextStyle(
                                color: AppColors.bananiPrimaryFg,
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'YOUNG VIP',
                                style: TextStyle(
                                  color: AppColors.bananiInk,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.35,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 3.5),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 12.0,
                                    height: 2.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.bananiAccent,
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  ),
                                  const SizedBox(width: 6.0),
                                  const Text(
                                    'Technology Lab',
                                    style: TextStyle(
                                      color: AppColors.bananiSlate,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right: Bell notification button & User Avatar
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onNotificationTap,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: AppColors.bananiCard,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.bananiBorder,
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bananiInk.withValues(alpha: 0.04),
                        blurRadius: 10.0,
                        offset: const Offset(0, 2.0),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.bananiInk,
                        size: 20.0,
                      ),
                      Positioned(
                        top: 10.0,
                        right: 12.0,
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            color: AppColors.bananiAccent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.bananiCard,
                              width: 1.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              GestureDetector(
                onTap: onAvatarTap ?? onOpenDrawer,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.bananiBorder,
                      width: 1.2,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.bananiLavender,
                          alignment: Alignment.center,
                          child: const Text(
                            'AL',
                            style: TextStyle(
                              color: AppColors.bananiPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
