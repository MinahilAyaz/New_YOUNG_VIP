import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../data/models/contextual_connection_model.dart';
import '../viewmodels/contextual_connection_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'lab_complete_view.dart';
import 'advise_better_view.dart';

class ContextualConnectionView extends StatelessWidget {
  const ContextualConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContextualConnectionViewModel>(
      create: (_) => ContextualConnectionViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.peachBackground,
        drawer: const CustomDrawer(),
        body: Consumer<ContextualConnectionViewModel>(
          builder: (context, vm, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 28.0 : screenWidth * 0.055;
            final data = vm.data;

            return SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540.0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 14.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context, vm),
                          const SizedBox(height: 20.0),
                          _buildHeroCard(context, data),
                          const SizedBox(height: 18.0),
                          _buildLabContextAnchorCard(data),
                          const SizedBox(height: 20.0),
                          _buildTabBar(context, vm),
                          const SizedBox(height: 18.0),
                          if (vm.activeTab == 0) ...[
                            _buildKnowledgeNodesSection(context, vm, data),
                          ] else if (vm.activeTab == 1) ...[
                            _buildPrecedentsSection(context, vm, data),
                          ] else ...[
                            _buildCrossDomainSection(context, vm, data),
                          ],
                          const SizedBox(height: 22.0),
                          _buildNextStepsCard(context, data),
                          const SizedBox(height: 88.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopBar(
      BuildContext context, ContextualConnectionViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AdviseBetterView()),
                  );
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
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.bananiInk,
                  size: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Builder(
              builder: (ctx) => GestureDetector(
                onTap: () => Scaffold.of(ctx).openDrawer(),
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
          ],
        ),

        const Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: YoungVipWordmark(),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: AppColors.bananiCard,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: AppColors.bananiBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.bookmark_added_rounded,
                color: AppColors.royalIndigo,
                size: 14.0,
              ),
              const SizedBox(width: 4.0),
              Text(
                '${vm.bookmarkedIds.length}',
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard(
      BuildContext context, ContextualConnectionModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.borderLight, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.bananiLavender,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.hub_rounded,
                        color: AppColors.royalIndigo,
                        size: 13.0,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'STAGE 05 • KNOWLEDGE SYNTHESIS',
                        style: TextStyle(
                          color: AppColors.royalIndigo,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF7E6),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: AppColors.youngVipGold.withValues(alpha: 0.4),
                  ),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.insights_rounded,
                        color: AppColors.youngVipGold,
                        size: 13.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        'Global Context',
                        style: TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Contextual Connection',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            data.contextObjective,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabContextAnchorCard(ContextualConnectionModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.bananiInk.withValues(alpha: 0.03),
            blurRadius: 10.0,
            offset: const Offset(0, 3.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: AppColors.bananiLavender,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Icon(
              Icons.science_rounded,
              color: AppColors.royalIndigo,
              size: 20.0,
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CURRENT LAB CONTEXT',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  data.labTitle,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  data.contextSummary,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(
      BuildContext context, ContextualConnectionViewModel vm) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isCompact = screenWidth < 400;
    final tabs = isCompact
        ? ['Standards', 'Precedents', 'Impact Matrix']
        : [
            'Standards & Frameworks',
            'Industry Precedents',
            'Impact Matrix',
          ];

    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = vm.activeTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => vm.setActiveTab(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.royalIndigo
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.pureWhite
                          : AppColors.textSecondary,
                      fontSize: 11.0,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildKnowledgeNodesSection(
      BuildContext context,
      ContextualConnectionViewModel vm,
      ContextualConnectionModel data) {
    return Column(
      children: data.knowledgeNodes.map((node) {
        final isBookmarked = vm.bookmarkedIds.contains(node.id);
        final isSelected = vm.selectedNodeId == node.id;

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 14.0),
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: isSelected
                  ? node.accentColor
                  : AppColors.borderLight,
              width: isSelected ? 1.6 : 1.0,
            ),
            boxShadow: AppColors.softShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8.0,
                runSpacing: 6.0,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: node.accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        node.category.toUpperCase(),
                        style: TextStyle(
                          color: node.accentColor,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7.0, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: AppColors.bananiBackground,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Text(
                            node.connectionStrength,
                            style: const TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        GestureDetector(
                          onTap: () => vm.toggleBookmark(node.id),
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: isBookmarked
                                ? AppColors.royalIndigo
                                : AppColors.textSecondary,
                            size: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: node.accentColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(node.icon, color: node.accentColor, size: 18.0),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      node.title,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                node.summary,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.5,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.bananiBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.link_rounded,
                            color: AppColors.royalIndigo,
                            size: 14.0,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            'HOW IT CONNECTS TO THIS LAB',
                            style: TextStyle(
                              color: AppColors.royalIndigo,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      node.takeaway,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 12.0,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPrecedentsSection(
      BuildContext context,
      ContextualConnectionViewModel vm,
      ContextualConnectionModel data) {
    return Column(
      children: data.precedents.map((prec) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 14.0),
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: AppColors.softShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8.0,
                runSpacing: 6.0,
                children: [
                  Text(
                    prec.sector.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: AppColors.bananiSuccessSoft,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      prec.quantifiableImpact,
                      style: const TextStyle(
                        color: AppColors.softGreen,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                prec.title,
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                prec.organization,
                style: const TextStyle(
                  color: AppColors.royalIndigo,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                prec.incidentSummary,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.5,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.bananiBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      size: 15.0,
                      color: AppColors.softGreen,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        prec.labSolutionMapping,
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCrossDomainSection(
      BuildContext context,
      ContextualConnectionViewModel vm,
      ContextualConnectionModel data) {
    return Column(
      children: data.domainImpacts.map((impact) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 14.0),
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: AppColors.softShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: AppColors.bananiLavender,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      impact.icon,
                      color: AppColors.royalIndigo,
                      size: 18.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          impact.domain,
                          style: const TextStyle(
                            color: AppColors.deepInk,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Primary Audience: ${impact.audience}',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.bananiCoralSoft,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: AppColors.coral.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        size: 15.0, color: AppColors.coral),
                    const SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        'Key Risk: ${impact.keyRisk}',
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 11.5,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.bananiSuccessSoft,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: AppColors.softGreen.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded,
                        size: 15.0, color: AppColors.softGreen),
                    const SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        'Mitigation: ${impact.mitigation}',
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 11.5,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNextStepsCard(
      BuildContext context, ContextualConnectionModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'KNOWLEDGE SPRINT COMPLETE',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Ready to Finalize Lab & Claim Credentials',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 16.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'You have successfully built, broken, analyzed, advised, and connected all systemic aspects of this AI Agents lab.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 18.0),
          CustomButton(
            label: 'Complete Lab & Claim +50 XP 🏆',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LabCompleteView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
