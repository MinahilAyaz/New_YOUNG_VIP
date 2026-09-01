import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/lab_model.dart';
import '../viewmodels/labs_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text_field.dart';
import 'lab_detail_view.dart';
import 'premium_lab_view.dart';

class LabsView extends StatelessWidget {
  const LabsView({super.key});

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
                      vertical: 16.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 24.0),
                          _buildHeading(),
                          const SizedBox(height: 20.0),
                          _buildSearchField(viewModel),
                          const SizedBox(height: 24.0),
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
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 1,
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openDrawer(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.centerLeft,
              child: const Icon(
                Icons.menu_rounded,
                color: AppColors.deepInk,
                size: 26.0,
              ),
            ),
          ),
        ),
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
          width: 38.0,
          height: 38.0,
          decoration: const BoxDecoration(
            color: AppColors.lightLavender,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'AV',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeading() {
    return Text(
      'Labs',
      style: AppTextStyles.headingLarge,
    );
  }

  Widget _buildSearchField(LabsViewModel viewModel) {
    final controller = TextEditingController(text: viewModel.searchQuery);
    return CustomTextField(
      hintText: 'Search Labs...',
      controller: controller,
      prefixIcon: Icons.search,
    );
  }

  Widget _buildLabList(BuildContext context, LabsViewModel viewModel) {
    return Column(
      children: viewModel.labs.map((lab) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildLabCard(context, lab),
        );
      }).toList(),
    );
  }

  Widget _buildLabCard(BuildContext context, LabModel lab) {
    final bool isAiAgents = lab.title == 'AI Agents';

    return CustomCard(
      backgroundColor: AppColors.pureWhite,
      padding: const EdgeInsets.all(18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: lab.tagBackgroundColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    lab.tagLabel,
                    style: TextStyle(
                      color: lab.tagTextColor,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  lab.title,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Build · Break · Understand · Advise',
                  style: TextStyle(
                    color: lab.accentColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          CustomButton(
            label: 'Open',
            onPressed: isAiAgents
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
            isPrimary: false,
          ),
        ],
      ),
    );
  }
}
