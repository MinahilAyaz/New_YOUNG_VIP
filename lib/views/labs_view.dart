import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/lab_model.dart';
import '../viewmodels/labs_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text_field.dart';
import 'lab_detail_view.dart';
import 'premium_lab_view.dart';

class LabsView extends StatelessWidget {
  final bool isRootTab;

  const LabsView({
    super.key,
    this.isRootTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LabsViewModel>(
      create: (_) => LabsViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
        body: Consumer<LabsViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;

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
                          _buildHeading(),
                          const SizedBox(height: 16.0),
                          _buildSearchField(viewModel),
                          const SizedBox(height: 16.0),
                          _buildCategoryPills(viewModel),
                          const SizedBox(height: 20.0),
                          _buildFeaturedHeroCard(context),
                          const SizedBox(height: 22.0),
                          _buildSectionHeader('All Interactive Labs (${viewModel.labs.length})'),
                          const SizedBox(height: 12.0),
                          _buildLabList(context, viewModel),
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
                currentIndex: 1,
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

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Interactive Labs',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Master AI builder workflows through live execution',
          style: TextStyle(
            color: AppColors.roomCardSubtext,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(LabsViewModel viewModel) {
    final controller = TextEditingController(text: viewModel.searchQuery);
    return CustomTextField(
      hintText: 'Search labs, skills, or workflows...',
      controller: controller,
      prefixIcon: Icons.search_rounded,
    );
  }

  Widget _buildCategoryPills(LabsViewModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: viewModel.categories.map((category) {
          final bool isSelected = viewModel.selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => viewModel.setCategory(category),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 7.0,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.deepInk : AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.deepInk
                        : const Color(0xFFEDE7F2),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.pureWhite
                        : AppColors.deepInk,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeaturedHeroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.heroCardPurple,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.heroCardPurple.withValues(alpha: 0.25),
            blurRadius: 18.0,
            offset: const Offset(0, 6.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF857A9D),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bolt_rounded,
                      color: Colors.white,
                      size: 13.0,
                    ),
                    SizedBox(width: 3.0),
                    Text(
                      'ACTIVE SPRINT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16.0),
                  SizedBox(width: 3.0),
                  Text(
                    '4.9 (1.2k)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Text(
            'AI Agents & Autonomous\nExecution Systems',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.5,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: const LinearProgressIndicator(
              value: 0.70,
              minHeight: 6.0,
              backgroundColor: Color(0xFF857A9D),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),
          const SizedBox(height: 8.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '70% Complete · 4/6 Modules',
                style: TextStyle(
                  color: AppColors.heroCardSubtext,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '⏱️ 20 min left',
                style: TextStyle(
                  color: AppColors.heroCardSubtext,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LabDetailView(),
                ),
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 7.5,
              ),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(24.0),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Continue Lab →',
                style: TextStyle(
                  color: Color(0xFF5B4F73),
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
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

  Widget _buildLabList(BuildContext context, LabsViewModel viewModel) {
    return Column(
      children: viewModel.labs.map((lab) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildLabCard(context, lab),
        );
      }).toList(),
    );
  }

  Widget _buildLabCard(BuildContext context, LabModel lab) {
    final bool isDetail = lab.title.contains('Agents') || lab.title.contains('Studio');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: const Color(0xFFEDE7F2),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: lab.tagBackgroundColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            alignment: Alignment.center,
            child: Icon(
              lab.icon,
              size: 22.0,
              color: lab.accentColor,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: lab.tagBackgroundColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        lab.tagLabel,
                        style: TextStyle(
                          color: lab.tagTextColor,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 14.0),
                    const SizedBox(width: 2.0),
                    Text(
                      lab.rating.toString(),
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  lab.title,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${lab.modules} · ${lab.duration}',
                  style: const TextStyle(
                    color: AppColors.roomCardSubtext,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          GestureDetector(
            onTap: isDetail
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LabDetailView(),
                      ),
                    );
                  }
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PremiumLabView(),
                      ),
                    );
                  },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6.5,
              ),
              decoration: BoxDecoration(
                color: isDetail ? AppColors.deepInk : AppColors.roomCardBg,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'Start',
                style: TextStyle(
                  color: isDetail ? AppColors.pureWhite : AppColors.deepInk,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
