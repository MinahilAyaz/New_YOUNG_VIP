import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/lab_room_model.dart';
import '../viewmodels/lab_room_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';

class LabRoomView extends StatelessWidget {
  final bool isRootTab;

  const LabRoomView({
    super.key,
    this.isRootTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LabRoomViewModel>(
      create: (_) => LabRoomViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
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
                      vertical: 12.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 18.0),
                          _buildHeader(roomData),
                          const SizedBox(height: 18.0),
                          _buildWeeklyCalendar(viewModel),
                          const SizedBox(height: 20.0),
                          _buildSectionHeader('Live Observations (${roomData.posts.length})'),
                          const SizedBox(height: 12.0),
                          _buildPostList(roomData.posts),
                          const SizedBox(height: 16.0),
                          _buildPostActionPill(context),
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
        bottomNavigationBar: isRootTab
            ? null
            : const CustomBottomNavBar(
                currentIndex: 2,
              ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openDrawer(),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 34.0,
                  height: 34.0,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: const Color(0xFFEDE7F2),
                      width: 1.0,
                    ),
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.deepInk,
                    size: 18.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'YOUNG ',
                        style: TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                      TextSpan(
                        text: 'VIP',
                        style: TextStyle(
                          color: AppColors.mutedPurple,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34.0,
              height: 34.0,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFEDE7F2),
                  width: 1.0,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.deepInk,
                    size: 18.0,
                  ),
                  Positioned(
                    top: 7.0,
                    right: 8.0,
                    child: Container(
                      width: 6.0,
                      height: 6.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 34.0,
              height: 34.0,
              decoration: const BoxDecoration(
                color: AppColors.avatarBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                'AV',
                style: TextStyle(
                  color: AppColors.avatarText,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
            color: AppColors.deepInk,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 3.5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFD1FAE5),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6.0,
                height: 6.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5.0),
              Text(
                roomData.peopleTag,
                style: const TextStyle(
                  color: Color(0xFF065F46),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyCalendar(LabRoomViewModel viewModel) {
    final days = [
      {'day': 'Mon', 'date': '12'},
      {'day': 'Tue', 'date': '13'},
      {'day': 'Wed', 'date': '14'},
      {'day': 'Thu', 'date': '15'},
      {'day': 'Fri', 'date': '16'},
      {'day': 'Sat', 'date': '17'},
      {'day': 'Sun', 'date': '18'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: const Color(0xFFEDE7F2),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(days.length, (index) {
          final isSelected = viewModel.selectedDayIndex == index;
          final item = days[index];

          return GestureDetector(
            onTap: () => viewModel.selectDay(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 10.0 : 8.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.deepInk : Colors.transparent,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Text(
                    item['day']!,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.pureWhite.withValues(alpha: 0.8)
                          : AppColors.roomCardSubtext,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    item['date']!,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.pureWhite
                          : AppColors.deepInk,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.deepInk,
        fontSize: 15.5,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      ),
    );
  }

  Widget _buildPostList(List<RoomPostModel> posts) {
    return Column(
      children: posts.map((post) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildPostCard(post),
        );
      }).toList(),
    );
  }

  Widget _buildPostCard(RoomPostModel post) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: const Color(0xFFEDE7F2),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
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
                  color: AppColors.avatarBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  post.initials,
                  style: const TextStyle(
                    color: AppColors.avatarText,
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.authorName,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      post.role,
                      style: const TextStyle(
                        color: AppColors.roomCardSubtext,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.5,
                    ),
                    decoration: BoxDecoration(
                      color: post.tagBgColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      post.tagLabel,
                      style: TextStyle(
                        color: post.tagTextColor,
                        fontSize: 9.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    post.timestamp,
                    style: const TextStyle(
                      color: AppColors.roomCardSubtext,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            post.content,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: [
              _buildInteractionChip(
                icon: Icons.favorite_border_rounded,
                label: '${post.likes}',
                onTap: () {},
              ),
              const SizedBox(width: 14.0),
              _buildInteractionChip(
                icon: Icons.chat_bubble_outline_rounded,
                label: '${post.replies}',
                onTap: () {},
              ),
              const Spacer(),
              const Icon(
                Icons.bookmark_border_rounded,
                size: 16.0,
                color: AppColors.roomCardSubtext,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.5, color: AppColors.roomCardSubtext),
          const SizedBox(width: 4.0),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.roomCardSubtext,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostActionPill(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.deepInk,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepInk.withValues(alpha: 0.15),
              blurRadius: 16.0,
              offset: const Offset(0, 4.0),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_rounded, color: AppColors.pureWhite, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              'Post Observation',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
