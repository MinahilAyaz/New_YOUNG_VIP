import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/peer_builder_model.dart';
import '../viewmodels/peers_view_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_drawer.dart';
import 'messages_view.dart';
import 'profile_view.dart';

class PeersView extends StatelessWidget {
  const PeersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PeersViewModel>(
      create: (_) => PeersViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        drawer: const CustomDrawer(),
        body: Consumer<PeersViewModel>(
          builder: (context, viewModel, _) {
            final double screenWidth = MediaQuery.of(context).size.width;
            final double horizontalPadding =
                screenWidth > 600 ? 24.0 : screenWidth * 0.055;
            final peersData = viewModel.peersData;

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
                          _buildTopBar(context),
                          const SizedBox(height: 28.0),
                          _buildHeading(peersData.title),
                          const SizedBox(height: 24.0),
                          _buildPeersList(context, peersData.peers),
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

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (ctx) => GestureDetector(
            onTap: () => Scaffold.of(ctx).openDrawer(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 36.0,
              height: 36.0,
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

  Widget _buildHeading(String title) {
    return Text(
      title,
      style: AppTextStyles.headingLarge.copyWith(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: AppColors.deepInk,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildPeersList(BuildContext context, List<PeerBuilderModel> peers) {
    return Column(
      children: peers.map((peer) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildPeerCard(context, peer),
        );
      }).toList(),
    );
  }

  Widget _buildPeerCard(BuildContext context, PeerBuilderModel peer) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.pureWhite,
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                peer.initials,
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    peer.name,
                    style: const TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    peer.role,
                    style: const TextStyle(
                      color: AppColors.blueGray,
                      fontSize: 12.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14.0),
                  Row(
                    children: [
                      CustomButton(
                        label: 'Profile',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfileView(),
                            ),
                          );
                        },
                        isPrimary: false,
                      ),
                      const SizedBox(width: 10.0),
                      CustomButton(
                        label: 'Connect',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MessagesView(),
                            ),
                          );
                        },
                        isPrimary: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
