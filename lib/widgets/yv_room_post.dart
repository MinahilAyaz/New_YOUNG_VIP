import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import 'custom_card.dart';

class YVRoomPost extends StatefulWidget {
  final String authorName;
  final String authorRole;
  final String avatarUrl;
  final String badgeText;
  final bool isFailureBadge;
  final String content;
  final String contextInfo;
  final int commentsCount;
  final int initialLikesCount;
  final VoidCallback? onTap;

  const YVRoomPost({
    super.key,
    required this.authorName,
    required this.authorRole,
    required this.avatarUrl,
    required this.badgeText,
    this.isFailureBadge = false,
    required this.content,
    required this.contextInfo,
    this.commentsCount = 24,
    this.initialLikesCount = 12,
    this.onTap,
  });

  @override
  State<YVRoomPost> createState() => _YVRoomPostState();
}

class _YVRoomPostState extends State<YVRoomPost> {
  late bool _isLiked;
  late int _likes;

  @override
  void initState() {
    super.initState();
    _isLiked = false;
    _likes = widget.initialLikesCount;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likes += _isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color badgeBg = widget.isFailureBadge
        ? AppColors.bananiCoralSoft
        : AppColors.bananiSuccessSoft;
    final Color badgeFg = widget.isFailureBadge
        ? AppColors.bananiCoral
        : AppColors.bananiSuccess;

    return CustomCard(
      backgroundColor: AppColors.bananiCard,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: AppColors.bananiBorder,
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.bananiInk.withValues(alpha: 0.05),
          blurRadius: 28.0,
          offset: const Offset(0, 10.0),
          spreadRadius: 0,
        ),
      ],
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header: Avatar + Info + Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  color: AppColors.bananiLavender,
                  child: Image.network(
                    widget.avatarUrl,
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          widget.authorName.isNotEmpty
                              ? widget.authorName[0]
                              : 'U',
                          style: const TextStyle(
                            color: AppColors.bananiPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.authorName,
                      style: const TextStyle(
                        color: AppColors.bananiInk,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      widget.authorRole,
                      style: const TextStyle(
                        color: AppColors.bananiSlate,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  widget.badgeText,
                  style: TextStyle(
                    color: badgeFg,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),

          // Body Content
          Text(
            widget.content,
            style: const TextStyle(
              color: AppColors.bananiInk,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14.0),

          // Divider
          Container(
            height: 1.0,
            color: AppColors.bananiBorder,
          ),
          const SizedBox(height: 12.0),

          // Footer Meta & Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.contextInfo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.bananiSlate,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Comments count
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: AppColors.bananiSlate,
                        size: 15.0,
                      ),
                      const SizedBox(width: 4.5),
                      Text(
                        '${widget.commentsCount}',
                        style: const TextStyle(
                          color: AppColors.bananiSlate,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14.0),

                  // Interactive Heart like button
                  GestureDetector(
                    onTap: _toggleLike,
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isLiked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: _isLiked
                              ? AppColors.bananiCoral
                              : AppColors.bananiSlate,
                          size: 16.5,
                        ),
                        if (_isLiked) ...[
                          const SizedBox(width: 4.0),
                          Text(
                            '$_likes',
                            style: const TextStyle(
                              color: AppColors.bananiCoral,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
