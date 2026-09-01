import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/lab_room_model.dart';
import '../viewmodels/lab_room_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_card.dart';

class LabRoomView extends StatelessWidget {
  const LabRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LabRoomViewModel>(
      create: (_) => LabRoomViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        body: Consumer<LabRoomViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final roomData = viewModel.roomData;

            return SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540.0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 20.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(),
                          const SizedBox(height: 28.0),
                          _buildHeader(roomData),
                          const SizedBox(height: 28.0),
                          _buildPostList(roomData.posts),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 2,
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'YOUNG ',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              TextSpan(
                text: 'VIP',
                style: TextStyle(
                  color: AppColors.youngVipGold,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 36.0,
          height: 36.0,
          decoration: const BoxDecoration(
            color: AppColors.lightLavender,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'AV',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(LabRoomModel roomData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          roomData.title,
          style: AppTextStyles.headingLarge.copyWith(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: AppColors.deepInk,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.softGreen.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Text(
            roomData.peopleTag,
            style: const TextStyle(
              color: AppColors.softGreen,
              fontSize: 10.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostList(List<RoomPostModel> posts) {
    return Column(
      children: posts.map((post) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildPostCard(post),
        );
      }).toList(),
    );
  }

  Widget _buildPostCard(RoomPostModel post) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.pureWhite,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: const BoxDecoration(
                    color: AppColors.lightLavender,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    post.initials,
                    style: const TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 3.0,
                        ),
                        decoration: BoxDecoration(
                          color: post.tagBgColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          post.tagLabel,
                          style: TextStyle(
                            color: post.tagTextColor,
                            fontSize: 9.0,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Text(
              post.content,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                const Icon(
                  Icons.favorite_border,
                  size: 14.0,
                  color: AppColors.blueGray,
                ),
                const SizedBox(width: 4.0),
                const Text(
                  'Like',
                  style: TextStyle(
                    color: AppColors.blueGray,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16.0),
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 13.0,
                  color: AppColors.blueGray,
                ),
                const SizedBox(width: 4.0),
                const Text(
                  'Reply',
                  style: TextStyle(
                    color: AppColors.blueGray,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
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
