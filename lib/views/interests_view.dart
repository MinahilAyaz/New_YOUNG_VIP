import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../data/models/interests_model.dart';
import '../viewmodels/interests_view_model.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'fluency_assessment_view.dart';

class InterestsView extends StatefulWidget {
  final VoidCallback? onCompleted;

  const InterestsView({
    super.key,
    this.onCompleted,
  });

  @override
  State<InterestsView> createState() => _InterestsViewState();
}

class _InterestsViewState extends State<InterestsView> {
  late final InterestsViewModel _viewModel;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = InterestsViewModel();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _handleComplete() async {
    final success = await _viewModel.saveInterests();
    if (!mounted) return;

    if (success) {
      if (widget.onCompleted != null) {
        widget.onCompleted!();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FluencyAssessmentView()),
        );
      }
    } else if (_viewModel.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.bananiCoral,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          content: Text(
            _viewModel.errorMessage!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  void _handleSkip() {
    if (widget.onCompleted != null) {
      widget.onCompleted!();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const FluencyAssessmentView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 24.0 : screenWidth * 0.055;

    return AnimatedBuilder(
      animation: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.bananiBackground,
          drawer: const CustomDrawer(),
          body: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580.0),
                child: Column(
                  children: [
                    // Top App Bar
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 10.0,
                      ),
                      child: _buildTopBar(context),
                    ),

                    // Scrollable Body
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Progress & Step Badge
                            _buildStepBadge(),
                            const SizedBox(height: 14.0),

                            // Hero Titles
                            const Text(
                              'What technologies and legal domains matter most to you?',
                              style: TextStyle(
                                color: AppColors.bananiInk,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.4,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              'Select at least 3 topics to curate your interactive lab queue, failure benchmarks, and legal architect network.',
                              style: TextStyle(
                                color: AppColors.bananiSlate,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w400,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 18.0),

                            // Selection Status Counter Card
                            _buildSelectionStatusCard(),
                            const SizedBox(height: 20.0),

                            // Quick Persona Presets
                            _buildPresetsSection(),
                            const SizedBox(height: 20.0),

                            // Search Field
                            _buildSearchBar(),
                            const SizedBox(height: 14.0),

                            // Category Filter Chips
                            _buildCategoryChips(),
                            const SizedBox(height: 16.0),

                            // Topic Cards
                            _buildTopicsList(),
                            const SizedBox(height: 100.0), // Spacer for dock
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomDock(context),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Drawer or Back button
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () {
              if (Navigator.canPop(ctx)) {
                Navigator.pop(ctx);
              } else {
                Scaffold.of(ctx).openDrawer();
              }
            },
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
              child: Icon(
                Navigator.canPop(context)
                    ? Icons.arrow_back_rounded
                    : Icons.menu_rounded,
                color: AppColors.bananiInk,
                size: 20.0,
              ),
            ),
          ),
        ),

        // Brand Wordmark
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: const YoungVipWordmark(),
            ),
          ),
        ),

        // Right: Skip action
        GestureDetector(
          onTap: _handleSkip,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: AppColors.bananiCard,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: AppColors.bananiBorder,
                width: 1.0,
              ),
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppColors.bananiSlate,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepBadge() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        Container(
          width: 24.0,
          height: 2.0,
          decoration: BoxDecoration(
            color: AppColors.bananiAccent,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: AppColors.bananiLavender,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            'ONBOARDING · STEP 02 OF 02',
            style: TextStyle(
              color: AppColors.bananiPrimary,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: AppColors.bananiCard,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: AppColors.bananiBorder, width: 1.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.stars_rounded,
                color: AppColors.bananiAccent,
                size: 13.0,
              ),
              SizedBox(width: 4.0),
              Text(
                '+100 XP REWARD',
                style: TextStyle(
                  color: AppColors.bananiAccent,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionStatusCard() {
    final isReady = _viewModel.canProceed;
    final selected = _viewModel.selectedCount;
    final minReq = _viewModel.minRequired;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: isReady
            ? AppColors.bananiSuccessSoft
            : AppColors.bananiCard,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isReady
              ? AppColors.bananiSuccess.withValues(alpha: 0.3)
              : AppColors.bananiBorder,
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isReady
                  ? AppColors.bananiSuccess
                  : AppColors.bananiLavender,
            ),
            alignment: Alignment.center,
            child: Icon(
              isReady ? Icons.check_rounded : Icons.pie_chart_outline_rounded,
              color: isReady ? Colors.white : AppColors.bananiPrimary,
              size: 18.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isReady
                      ? '$selected Topics Selected · Ready to Launch!'
                      : '$selected of $minReq Minimum Selected',
                  style: TextStyle(
                    color: isReady ? AppColors.bananiSuccess : AppColors.bananiInk,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  isReady
                      ? 'Your custom curriculum & peer recommendations are unlocked.'
                      : 'Select ${_viewModel.remainingToSelect} more to complete onboarding.',
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
    );
  }

  Widget _buildPresetsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
              child: Text(
                'Quick Start Presets',
                style: TextStyle(
                  color: AppColors.bananiInk,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'One-tap fill',
              style: TextStyle(
                color: AppColors.bananiSlate,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _viewModel.model.presets.map((preset) {
            final isPresetActive = _viewModel.activePresetId == preset.id;
            return GestureDetector(
              onTap: () => _viewModel.applyPreset(preset),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: isPresetActive
                      ? AppColors.bananiPrimary
                      : AppColors.bananiCard,
                  borderRadius: BorderRadius.circular(9.0),
                  border: Border.all(
                    color: isPresetActive
                        ? AppColors.bananiPrimary
                        : AppColors.bananiBorder,
                    width: 1.0,
                  ),
                  boxShadow: isPresetActive
                      ? [
                          BoxShadow(
                            color: AppColors.bananiPrimary.withValues(alpha: 0.25),
                            blurRadius: 8.0,
                            offset: const Offset(0, 3.0),
                          ),
                        ]
                      : null,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        preset.icon,
                        size: 15.0,
                        color: isPresetActive ? Colors.white : AppColors.bananiInk,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        preset.name,
                        style: TextStyle(
                          color:
                              isPresetActive ? Colors.white : AppColors.bananiInk,
                          fontSize: 12.5,
                          fontWeight:
                              isPresetActive ? FontWeight.w700 : FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return CustomCard(
      backgroundColor: AppColors.bananiCard,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: AppColors.bananiBorder, width: 1.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: AppColors.bananiSlate,
            size: 18.0,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _viewModel.setSearchQuery,
              style: const TextStyle(
                color: AppColors.bananiInk,
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                hintText: 'Search topics, regulations, or technologies…',
                hintStyle: TextStyle(
                  color: AppColors.bananiSlate,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
          ),
          if (_viewModel.searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _viewModel.clearSearch();
              },
              behavior: HitTestBehavior.opaque,
              child: const Icon(
                Icons.close_rounded,
                color: AppColors.bananiSlate,
                size: 18.0,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _viewModel.categories.map((category) {
          final isSelected = _viewModel.selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => _viewModel.setCategory(category),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 7.0,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.bananiLavender
                      : AppColors.bananiCard,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.bananiPrimary
                        : AppColors.bananiBorder,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.bananiPrimary
                        : AppColors.bananiSlate,
                    fontSize: 12.0,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTopicsList() {
    final topics = _viewModel.filteredTopics;

    if (topics.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: Column(
          children: const [
            Icon(
              Icons.search_off_rounded,
              size: 40.0,
              color: AppColors.bananiSlate,
            ),
            SizedBox(height: 10.0),
            Text(
              'No topics match your filter.',
              style: TextStyle(
                color: AppColors.bananiInk,
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Try adjusting your search terms or category filter.',
              style: TextStyle(
                color: AppColors.bananiSlate,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: topics.map((topic) => _buildTopicCard(topic)).toList(),
    );
  }

  Widget _buildTopicCard(TopicInterest topic) {
    final isSelected = _viewModel.isTopicSelected(topic.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () => _viewModel.toggleTopic(topic.id),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.bananiCard
                : AppColors.bananiCard,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: isSelected
                  ? AppColors.bananiPrimary
                  : AppColors.bananiBorder,
              width: isSelected ? 1.8 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? AppColors.bananiPrimary.withValues(alpha: 0.12)
                    : AppColors.bananiInk.withValues(alpha: 0.04),
                blurRadius: isSelected ? 16.0 : 8.0,
                offset: const Offset(0, 4.0),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Icon + Category + Badges + Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.bananiPrimary
                          : AppColors.bananiLavender,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      topic.icon,
                      color: isSelected ? Colors.white : AppColors.bananiPrimary,
                      size: 19.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6.0,
                      runSpacing: 4.0,
                      children: [
                        Text(
                          topic.category,
                          style: const TextStyle(
                            color: AppColors.bananiSlate,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (topic.badgeText.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 2.5,
                            ),
                            decoration: BoxDecoration(
                              color: topic.badgeText == 'HOT' ||
                                      topic.badgeText == 'CRITICAL'
                                  ? AppColors.bananiCoralSoft
                                  : AppColors.bananiAccent.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              topic.badgeText,
                              style: TextStyle(
                                color: topic.badgeText == 'HOT' ||
                                        topic.badgeText == 'CRITICAL'
                                    ? AppColors.bananiCoral
                                    : AppColors.bananiAccent,
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.bananiPrimary
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.bananiPrimary
                            : AppColors.bananiBorder,
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: isSelected
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 16.0,
                          )
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Topic Title
              Text(
                topic.title,
                style: const TextStyle(
                  color: AppColors.bananiInk,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 5.0),

              // Description
              Text(
                topic.description,
                style: const TextStyle(
                  color: AppColors.bananiSlate,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12.0),

              // Meta Row: Labs + Builders
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bananiBackground,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          color: AppColors.bananiBorder,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.science_outlined,
                            color: AppColors.bananiSlate,
                            size: 13.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            topic.labsCount,
                            style: const TextStyle(
                              color: AppColors.bananiInk,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bananiBackground,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          color: AppColors.bananiBorder,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.people_outline_rounded,
                            color: AppColors.bananiSlate,
                            size: 13.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            topic.buildersCount,
                            style: const TextStyle(
                              color: AppColors.bananiSlate,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
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
      ),
    );
  }

  Widget _buildBottomDock(BuildContext context) {
    final bool canProceed = _viewModel.canProceed;
    final int remaining = _viewModel.remainingToSelect;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 20.0),
      decoration: BoxDecoration(
        color: AppColors.bananiCard,
        border: const Border(
          top: BorderSide(color: AppColors.bananiBorder, width: 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.bananiInk.withValues(alpha: 0.08),
            blurRadius: 20.0,
            offset: const Offset(0, -4.0),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 48.0,
          child: ElevatedButton(
            onPressed: _viewModel.isLoading ? null : _handleComplete,
            style: ElevatedButton.styleFrom(
              backgroundColor: canProceed
                  ? AppColors.bananiPrimary
                  : AppColors.bananiBorder,
              foregroundColor: canProceed
                  ? Colors.white
                  : AppColors.bananiSlate,
              disabledBackgroundColor:
                  AppColors.bananiPrimary.withValues(alpha: 0.5),
              elevation: canProceed ? 2 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: _viewModel.isLoading
                ? const SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          canProceed
                              ? 'Continue to Fluency Assessment'
                              : 'Select $remaining more topic${remaining == 1 ? '' : 's'}',
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (canProceed) ...[
                          const SizedBox(width: 8.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.bananiAccent,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              '+100 XP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          const Icon(Icons.arrow_forward_rounded, size: 16.0),
                        ],
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
